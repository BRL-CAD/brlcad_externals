/*                  S T R C L E A R . C P P
 * BRL-CAD
 *
 * Copyright (c) 2018-2023 United States Government as represented by
 * the U.S. Army Research Laboratory.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided
 * with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote
 * products derived from this software without specific prior written
 * permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
/** @file strclear.cpp
 *
 * Two modes for this tool:
 *
 * Given a binary (or text) file and a string, replace any instances of the
 * string in the binary with null chars.
 *
 * Given a text file, a target string and a replacement string, replace all
 * instances of the target string with the replacement string.
 * TODO: For the moment, the replacement string can't contain the target string.
 */

#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <sstream>
#include <string>
#include <vector>

int
process_binary(std::string &fname, std::vector<std::string> &target_strs, bool verbose)
{
    // Read binary contents
    std::ifstream input_fs;
    input_fs.open(fname, std::ios::binary);
    if (!input_fs.is_open()) {
	std::cerr << "Unable to open file " << fname << "\n";
	return -1;
    }
    std::vector<char> bin_contents(std::istreambuf_iterator<char>(input_fs), {});
    input_fs.close();

    // Set up vectors of target and array of null chars
    int grcnt = 0;
    for (size_t i = 0; i < target_strs.size(); i++) {
	std::vector<char> search_chars(target_strs[i].begin(), target_strs[i].end());
	std::vector<char> null_chars;
	for (size_t j = 0; j < search_chars.size(); j++)
	    null_chars.push_back('\0');

	// Find instances of target string in binary, and replace any we find
	auto position = std::search(bin_contents.begin(), bin_contents.end(), search_chars.begin(), search_chars.end());
	int rcnt = 0;
	while (position != bin_contents.end()) {
	    std::copy(null_chars.begin(), null_chars.end(), position);
	    rcnt++;
	    if (verbose)
		std::cout << "Replacing instance #" << rcnt << " of " << target_strs[i] << "\n";
	    position = std::search(position, bin_contents.end(), search_chars.begin(), search_chars.end());
	}
	grcnt += rcnt;
    }
    if (!grcnt)
	return 0;

    // If we changed the contents, write them back out
    std::ofstream output_fs;
    output_fs.open(fname, std::ios::binary);
    if (!output_fs.is_open()) {
	std::cerr << "Unable to write updated file contents for " << fname << "\n";
	return -1;
    }

    std::copy(bin_contents.begin(), bin_contents.end(), std::ostreambuf_iterator<char>(output_fs));
    output_fs.close();

    return 0;
}

int
process_text(std::string &fname, std::string &target_str, std::string &replace_str, bool verbose)
{
    // Make sure the replacement doesn't contain the target.  If we need that
    // we'll have to be more sophisticated about the replacement logic, but
    // for now just be simple
    auto loop_check = std::search(replace_str.begin(), replace_str.end(), target_str.begin(), target_str.end());
    if (loop_check != replace_str.end()) {
	std::cerr << "Replacement string \"" << replace_str << "\" contains target string \"" << target_str << "\" - unsupported.\n";
	return -1;
    }

    std::ifstream input_fs(fname);
    std::stringstream fbuffer;
    fbuffer << input_fs.rdbuf();
    std::string nfile_contents = fbuffer.str();
    input_fs.close();
    auto position = std::search(nfile_contents.begin(), nfile_contents.end(), target_str.begin(), target_str.end());
    if (position == fbuffer.str().end())
	return 0;
    int rcnt = 0;
    while (position != nfile_contents.end()) {
	nfile_contents.replace(nfile_contents.find(target_str), target_str.size(), replace_str);
	rcnt++;
	if (verbose)
	    std::cout << "Replacing instance #" << rcnt << " of " << target_str << " with " << replace_str << "\n";
	position = std::search(nfile_contents.begin(), nfile_contents.end(), target_str.begin(), target_str.end());
    }
    if (!rcnt)
	return 0;

    // If we changed the contents, write them back out
    std::ofstream output_fs;
    output_fs.open(fname, std::ios::trunc);
    if (!output_fs.is_open()) {
	std::cerr << "Unable to write updated file contents for " << fname << "\n";
	return -1;
    }
    output_fs << nfile_contents;
    output_fs.close();
    return 0;
}

int
main(int argc, const char *argv[])
{
    bool verbose = false;
    bool binary_mode = false;
    bool text_mode = false;
    const char *usage = "Usage: strclear [-v] [-b] [-t] file string_to_clear [replacement_string]";

    argc--; argv++;

    if (argc < 2) {
	std::cerr << usage << "\n";
	return -1;
    }

    while (argc > 2 && argv[0][0] == '-') {
	const char *arg = argv[0];
	argc--; argv++;
	if (std::string(arg) == std::string("-v")) {
	    verbose = true;
	    continue;
	}
	if (std::string(arg) == std::string("-b")) {
	    binary_mode = true;
	    continue;
	}
	if (std::string(arg) == std::string("-t")) {
	    text_mode = true;
	    continue;
	}
	std::cerr << usage << "\n";
	return -1;
    }

    if (binary_mode && text_mode) {
	std::cerr << "Error:  need to specify either binary or text mode, not both\n";
	return -1;
    }

    // If we only have a filename and a single string, the only thing we can
    // do is treat the file as binary and replace the string
    if (argc == 2)
	binary_mode = true;

    std::string fname(argv[0]);

    // Determine if the file is a binary or text file, if we've not been told
    // to treat it as binary explicitly with -b.
    if (!binary_mode) {
	std::ifstream check_fs;
	check_fs.open(fname);
	int c;
	while ((c = check_fs.get()) != EOF && c < 128);
	binary_mode = (c == EOF) ? false : true;
	check_fs.close();
    }

    if (binary_mode && text_mode) {
	if (verbose)
	    std::cerr << "Text mode specified, but file is binary - no op\n";
	return 0;
    }

    // If we're explicitly in binary mode or we have no replacement
    // string, we're just nulling out the target string.
    if (binary_mode) {
	std::vector<std::string> target_strs;
	for (int i = 1; i < argc; i++) {
	    target_strs.push_back(std::string(argv[i]));
	}
	return process_binary(fname, target_strs, verbose);
    }

    if (argc > 3) {
	std::cerr << "Error:  processing text file, but more than three args supplied.  For text files, the supported mode is to replace a single string with a replacement.\n";
	return -1;
    }
    std::string target_str(argv[1]);
    std::string replace_str(argv[2]);
    return process_text(fname, target_str, replace_str, verbose);
}

// Local Variables:
// tab-width: 8
// mode: C++
// c-basic-offset: 4
// indent-tabs-mode: t
// c-file-style: "stroustrup"
// End:
// ex: shiftwidth=4 tabstop=8

