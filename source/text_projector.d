version (_wait_):
struct
Text_Projector {
    //void
    //project (Locate* locate, Target* target) {
    //    // calc projected
    //    locate.projected.len = locate.defined.len.project (target.len);
    //}
    void
    project (Text_Style_Image* text_style_image, Target* target) {
        foreach (i; 0..text_style_image.length)
            writeln (
                format (
                    text_style_image.style_s[i],
                    text_style_image. char_s[i]
                )
            );
    }
}

struct
Target {
    L len;
}

// Text_Projector ().project (text,target);
