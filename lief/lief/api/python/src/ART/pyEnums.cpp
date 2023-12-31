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
#include "pyART.hpp"
#include "LIEF/ART/enums.hpp"
#include "LIEF/ART/EnumToString.hpp"

#define PY_ENUM(x) to_string(x), x

namespace LIEF {
namespace ART {
void init_enums(py::module& m) {

  py::enum_<STORAGE_MODES>(m, "STORAGE_MODES")
    .value(PY_ENUM(STORAGE_MODES::STORAGE_UNCOMPRESSED))
    .value(PY_ENUM(STORAGE_MODES::STORAGE_LZ4))
    .value(PY_ENUM(STORAGE_MODES::STORAGE_LZ4HC));

}
}
}
