Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137146;
	b=LN9VwrfRKr/g8p8IUN11La1BQMmpYqjrHxsPQ6QZmumGMvrr6M4Hl+7GlD9bh8T5ciaJ
	 LY5wOEgcPfTu5GJ9oqSFeKywPmL6RxK6fKk315tBKED9nHc+p/OajY5QLs+LIGAzm0LLY
	 TjljDL1rIrvi/dRehqau1g3sJEoBKIus59/go+o3PkIUKPwtyqIWxxRNPKcA+uF4JX1+u
	 P8CMvu9s4QcApXKPTV9ZZg+1D3uhMvhxVaeM54TDwHIYPVqfjISY7dmxFvOJWnFcnhrPR
	 S1p2yqASrT3c0bqR5+COf4JTlp2VRecG9NdN1r5bA3jGiLCbYe/HFDcGsQWSnfGBRQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
	b=UO0a/IfWllVdebH6ITIZle/7vc94khYdKqEGqorD40TaQ3SzwkLAiINL+E9E7X7hTfTk
	 Pf/BPQP0lpQiJRIZ8WP9zUOM4J7riRB/24LidvNf6ejlSKe1euD7AMhGzj2g7mkO4xdwF
	 ZgOsfTL+mhdOK6HtlNixKdDTxU8Zy35mEP9z0g6X/oNW0OpqyLONw8BjcmQpsheMJJhEi
	 GBhhEbniOHP5J1nc5WsiobEXFnrWb4YCxHnVg43U27O10Sc7uYOvE9JZz3v2LD4hPY/h/
	 m9ysiPngg2iLwaRQCV8t+j+zbIFyM/I2+UEJIjauJCXGXl83maazKXgDgCDQBVesQBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s8dfTSFA;
	arc=none smtp.remote-ip=74.125.227.128
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC556606A5C9
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 01:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC556606A5C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s8dfTSFA
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3aec0b1d816so197951a91.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 17:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795137145; x=1795741945; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
        b=s8dfTSFA3AmA3aIE+gKsigKh4J5hAfQdYqOrTmcO5WeZ8ytpEMfuCG2mzm+NqTujSp
         nGtfnae9n3tkWiJNnQMFAl5e6X8lbdyD8TDt8ilryuUH2Q37/wi2js1S3asKvJE27zGk
         +dGAlMt0H1HtMYbsqbs+N0SLiZTM/RkBppxFGzLSS/E/QDGbyNoxFA2n9408P5UAyMUl
         aIPN5gwX/POongn/WZ/ReELsoWxlHsGynPwAdlVcWbu4Z7vLw79/EUk3BHbobfv1q4sM
         5VjwBXwZ3RvTYNPS/Ob3m/MW7jUGVPcsMfp2VN3a151FaVzWKmq0UTQP4xbmgvFlIeFV
         mUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137145; x=1795741945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
        b=VNvrp2pnWv9iooKLXe76W8bIQmvq73Kox+Xf2gP8jLRFK0BlmyRoOFoB5r4TY9U7UR
         Exp4uA+vzXbDaGjgYHft8ygydYtrBzq+uP6URNFtO4sn13TP7DgswgtZGVccb3lUlGjF
         OVmM8Z1Jh/AMLqc6OhJqMXeuCfmNqisSRtBH9i6Z/ubOY42w/lurBYwjsMLz7DToqrVw
         CPIXt/I5pOSQnyPC4O8OxsDMZbS/pUdHgcVt+BvlXdxRd18RxcFEl4VFiLWCVJHi/Bgy
         n2/lJdiKl08GIXZWdZzzRZWq3gdBYwKsWfpkzasNLLAPUGTN56qwMJLhdPG4WZk5Cu4U
         UpkA==
X-Forwarded-Encrypted: i=1; AL+hErHTyeQUNo76CR50zgTKIo1kpkArv3RJ9ruAgcLU94shNKiiix5UZK7f0c81xEYui/ztjZFYvje2isLJOwZNkg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9lawM7tUS1O8egw9p0Tw5ez+ckJ+MERTUqJbn2TRTPZWATyrIY
	EjPmaaz7ojS6n7DKdpFGC7dqLRf144hSeCecQdU8H+x3FN9wS46/mAoD
X-Gm-Gg: AZFdTZcO1LBe86/ySCGkhUOueJxTklYejdiXzk7hYr6AMq8HcYa/cZbxMUiRdSZ72+c
	IWAB/jjLvlT7RyNJPuxLujA629JBdYx1z801CrBb70gu+TL5l0PJM7jtiaqxaeKZxjeoqEiAvSr
	aul/hg5djT6XqX5nXbJJM6wRef/Y00q08ikgERtmh2KVFRdKUrwtSZu0oZfT9OIG8GfHmov91LH
	DcbYQdwNyyGLiuKoLfuzWqGClUgYifDKmQ78EOoZlPW+OETS64MjvG0nR3i6oqT7KUzfzQdPsQk
	shV/ZsvhLn2WWOx4JRzdVlBKTRy63kfYiiL7mPZ4btj/4C0hiR3VWDCvC+hSA9nBQ2f/ZonRD2n
	5Ld57uWLXCGITji3nrd+kXDDo9fEYm/WvuuJTB0psDD0vy6g1KTs6oa+qm5EZvfnWZHt8RWV9ch
	6xJWHOaMy8p9Ym1pvOVJEV74XwNr2c89KtGnFsNRBmep/oSJ4EwiqJQsA2ElUvcYRe/o+PQ5Iqs
	MhUBDfDkrLeoVzBuD7DVlZBygUzV++rZD3rhi8P6PIOd6NM0wPI8HspDAY7+TtNHTmZBHl+ba1g
	yf2BmrSXGJslj2COq+1Iekg/4UJyBy2ryHX5fNklhjlCy6xDgnUhoXBFKIsonK8IeJbxdmD3XJH
	3iAp+JsVsNWI6
X-Received: by 2002:a17:90b:268f:b0:3b0:d0c5:c110 with SMTP id 98e67ed59e1d1-3b41c95ce7fmr1046872a91.56.1795137145051;
        Thu, 19 Nov 2026 17:12:25 -0800 (PST)
Received: from localhost ([50.7.253.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d243eb1sm622215a91.3.2026.11.19.17.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:12:24 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Fri, 20 Nov 2026 12:05:48 +1100
Subject: [PATCH RESEND v2 2/2] HID: picolcd: Avoid framebuffer last-close
 deadlock
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20261120-mail-picolcd-v2-resend-20261120-v2-2-d7531fa8061b@gmail.com>
References: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
In-Reply-To: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, deller@gmx.de, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Clark Williams <clrkwllms@kernel.org>, bigeasy@linutronix.de, 
 linux-input@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Takashi Iwai <tiwai@suse.de>, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 linux-rt-devel@lists.linux.dev, simona@ffwll.ch, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
X-Mailer: b4 0.16.0

Closing the last framebuffer descriptor can deadlock against PicoLCD's
deferred update worker. fb_release() holds info->lock while waiting for
deferred work, and picolcd_fb_update() takes the same lock. Lockdep
reports the cycle through deferred-work completion and fbdefio_state->lock.
Repeated framebuffer open/write/close with concurrent device destruction
reproduces the hang in a PREEMPT_RT QEMU guest.

Use a private update mutex in the deferred worker instead of info->lock.
Take it in picolcd_set_par() as well to preserve serialization of pixel
format conversion and framebuffer updates. Initialize it before exposing
the framebuffer.

The test with the preceding output-request fix hung in the first round
and reported a circular locking dependency. With this change, all five
rounds completed, including 29 successful framebuffer write cycles and
concurrent LCD, backlight, two LED and UHID destroy operations, without
BUG/WARNING. The original syzkaller reproducer and persistent-open
framebuffer tests also passed again. These are bounded virtual-device
tests; physical hardware and suspend/resume remain untested.

Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing deferred=
 I/O devices")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/hid/hid-picolcd.h    |  2 ++
 drivers/hid/hid-picolcd_fb.c | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
index 846a8ceb95..33e6654ca0 100644
--- a/drivers/hid/hid-picolcd.h
+++ b/drivers/hid/hid-picolcd.h
@@ -115,6 +115,8 @@ struct picolcd_data {
 struct picolcd_fb_data {
 	/* Framebuffer stuff */
 	spinlock_t lock;
+	/* Deferred I/O runs while fbdefio_state->lock is held. */
+	struct mutex update_lock;
 	struct picolcd_data *picolcd;
 	u8 update_rate;
 	u8 bpp;
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index c17104fd60..258c7c4fa2 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -231,7 +231,8 @@ static void picolcd_fb_update(struct fb_info *info)
 	struct picolcd_fb_data *fbdata =3D info->par;
 	struct picolcd_data *data;
=20
-	mutex_lock(&info->lock);
+	/* fb_release() flushes this work while holding info->lock. */
+	mutex_lock(&fbdata->update_lock);
=20
 	spin_lock_irqsave(&fbdata->lock, flags);
 	data =3D !fbdata->ready ? fbdata->picolcd : NULL;
@@ -258,11 +259,11 @@ static void picolcd_fb_update(struct fb_info *info)
 				spin_lock_irqsave(&fbdata->lock, flags);
 				data =3D fbdata->picolcd;
 				spin_unlock_irqrestore(&fbdata->lock, flags);
-				mutex_unlock(&info->lock);
+				mutex_unlock(&fbdata->update_lock);
 				if (!data)
 					return;
 				hid_hw_wait(data->hdev);
-				mutex_lock(&info->lock);
+				mutex_lock(&fbdata->update_lock);
 				n =3D 0;
 			}
 			spin_lock_irqsave(&fbdata->lock, flags);
@@ -277,13 +278,13 @@ static void picolcd_fb_update(struct fb_info *info)
 		spin_lock_irqsave(&fbdata->lock, flags);
 		data =3D fbdata->picolcd;
 		spin_unlock_irqrestore(&fbdata->lock, flags);
-		mutex_unlock(&info->lock);
+		mutex_unlock(&fbdata->update_lock);
 		if (data)
 			hid_hw_wait(data->hdev);
 		return;
 	}
 out:
-	mutex_unlock(&info->lock);
+	mutex_unlock(&fbdata->update_lock);
 }
=20
 static int picolcd_fb_blank(int blank, struct fb_info *info)
@@ -332,17 +333,24 @@ static int picolcd_set_par(struct fb_info *info)
 {
 	struct picolcd_fb_data *fbdata =3D info->par;
 	u8 *tmp_fb, *o_fb;
+	int ret =3D 0;
+
+	mutex_lock(&fbdata->update_lock);
 	if (info->var.bits_per_pixel =3D=3D fbdata->bpp)
-		return 0;
+		goto out;
 	/* switch between 1/8 bit depths */
-	if (info->var.bits_per_pixel !=3D 1 && info->var.bits_per_pixel !=3D 8)
-		return -EINVAL;
+	if (info->var.bits_per_pixel !=3D 1 && info->var.bits_per_pixel !=3D 8) {
+		ret =3D -EINVAL;
+		goto out;
+	}
=20
 	o_fb   =3D fbdata->bitmap;
 	tmp_fb =3D kmalloc_array(PICOLCDFB_SIZE, info->var.bits_per_pixel,
 			       GFP_KERNEL);
-	if (!tmp_fb)
-		return -ENOMEM;
+	if (!tmp_fb) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
=20
 	/* translate FB content to new bits-per-pixel */
 	if (info->var.bits_per_pixel =3D=3D 1) {
@@ -369,7 +377,9 @@ static int picolcd_set_par(struct fb_info *info)
=20
 	kfree(tmp_fb);
 	fbdata->bpp =3D info->var.bits_per_pixel;
-	return 0;
+out:
+	mutex_unlock(&fbdata->update_lock);
+	return ret;
 }
=20
 static void picolcdfb_ops_damage_range(struct fb_info *info, off_t off, si=
ze_t len)
@@ -506,6 +516,7 @@ int picolcd_init_framebuffer(struct picolcd_data *data)
=20
 	fbdata =3D info->par;
 	spin_lock_init(&fbdata->lock);
+	mutex_init(&fbdata->update_lock);
 	fbdata->picolcd =3D data;
 	fbdata->update_rate =3D PICOLCDFB_UPDATE_RATE_DEFAULT;
 	fbdata->bpp     =3D picolcdfb_var.bits_per_pixel;

--=20
2.56.1

