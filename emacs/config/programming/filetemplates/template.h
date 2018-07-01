%( (when (file-exists-p (setq license_file_name (concat (projectile-project-root) "LICENSE")))
    (string-insert-rectangle 0
     (nth 1 (insert-file-contents
             license_file_name )) "/// " ) )
    %) %((whitespace-cleanup)%)
/// \file      %b
///
/// \brief     <brief description>
///
/// \author    %U - <%a>
/// \date      %d-%m-%Y

#ifndef %N_H_
#define %N_H_

%@

#endif /* %N_H_ */
