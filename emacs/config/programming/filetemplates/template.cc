%(
        (when (file-exists-p (setq license_file_name (concat (projectile-project-root) "LICENSE")))
         (string-insert-rectangle 0
          (nth 1 (insert-file-contents
                  license_file_name )) "/// " ) )
    %) %((whitespace-cleanup)%)
/// \file      %b
///
/// \author    %U - <%a>
/// \date      %d-%m-%Y

// Local includes.
#include "%n.h"

%@
