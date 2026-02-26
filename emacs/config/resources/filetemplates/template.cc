%( (when (file-exists-p (setq license_file_name "~/.emacs.d/config/resources/filetemplates/license.txt"))
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
