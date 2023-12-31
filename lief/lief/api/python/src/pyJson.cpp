/* Copyright 2017 - 2023 R. Thomas
 * Copyright 2017 - 2023 Quarkslab
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "LIEF/config.h"
#include "LIEF/json.hpp"
#include "LIEF/Abstract/json.hpp"
#include "LIEF/Object.hpp"

#include "pyLIEF.hpp"

void init_json_functions(py::module& m) {
  m.def("to_json", &LIEF::to_json);
  m.def("to_json_from_abstract", &LIEF::to_json_from_abstract);
}
