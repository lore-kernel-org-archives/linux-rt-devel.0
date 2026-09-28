Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B074AF668
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.203
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596012; cv=pass; b=sxOTAGjAU+Rf5gzyKERmesXZU3RmpUTiKbzhy8f2HcS9XHvgjDIWjqo+UxOgU5/+FnTzlIGkGBdjSIJcC1Wdj/4oDiUVAyKBBlaG4PIEatyQrMLA43rAGvnXJSADm2SAJJFp90RNWxClrZXAHSxoI+xiMUoRtE0ErlV0SCi2Mdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596012; c=relaxed/simple;
	bh=lBv8IBD6IJb/z9r6xNQnFgugXVsOeX1D0j5YFBOsNP8=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=YisCfOPy7lv6Wgiwh0F+B1456dTvVwXvViFOxVgo3P3g5ijDeih62OD8++CSof0Rrsr+ljfpokpcROCeku/JwFjHPKwb7Ey1UZRjQpBKAlMavRX7s5jMBUxdaDazNLrckGYjMZZ/mERqqu5XDIsjrkm9gTP+DhpwG9+cTCA6h/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS7CmSAc; arc=pass smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS7CmSAc"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4e7133c0eeaso247425b6e.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 04:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790596008; cv=none;
        d=google.com; s=arc-20260327;
        b=sgZQrIqpONztJDTPZMzBnf5dWMijw8U1LBqXwGEzOyV0lYAxe9SvBGWe/FV3yZH52L
         pAujVtiNd+VqOlQrcMZPBGDPJy5d6HFakAjoXrWbYO6RDyt/skBt1x9WGsufIkFwvxaT
         uccjdqEjGf0LSpHO3XyoWiIUFHU8gsm/a18kwuRb+lI6d6TynZ96pPYqI6LBoJNgCAu2
         DBrX5DM2tGbg7tjYAyP+hDIPeyM0p4vMDV6rnoxkhxhedGMr3udMJKwhgtvmVpJPj/4n
         A3EaLJ/35k9M5eDG357RgCHb2NxYAKTr9MwJe1BvJBjHHGlTeF4v7Ky6CsIM7JyEJ2av
         Jwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
        fh=mC4EkNX42ZdQC8GltcQIDeNPOEqdkHkZjpn9pBRfsqs=;
        b=U9r5eDEt+FRieABU7h3Oca09wom56MsvgBTb4SC5aqm5ZN1CEqVd3l+q6JmopdFieI
         fMo8FGAnFTP/QwK5yAaDP8rdGo9IGZgJFsb/8FVNC5oVNBAGw0cKhpMeMw26xQqjQdpZ
         8C83vFNHIfJsqYdgKMacgXQ/7Sy9XncHOLNUvhi1WL7VFVcu1QGMpqY4Lsm3I0fs+WRB
         GpuWjnjJ5GWsj4bmAP+Ipe8nDueupUXraWK5xMD5odOsjy8EEOAn0K54MilBVKTr65ay
         WoahYYZERaPkdoT+AaGxVnBdMAuaVwa/rQoQcQptC/dBh4L03MoyjWRY0BsyMMetacjp
         bGSQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596008; x=1791200808; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
        b=jS7CmSAc0BNZyns0JgTRDUVtlgIa66roI4GT9s5rMPu56gKuACkQTP9tXIcjMH1R96
         Nm/+qb7U5KmiJ9yEvY+4uXcx8OKAHG2H2QSDWKg/cKcF9cM2Wb4C0jsYNeCW05OxbALi
         nXHTmBJgfeBlu5+EG8hPcIbzJxMNAt20nHHb8soWYTwe016eIUxamO2KXIQrkO3mAJyK
         4PtUHoxaB3zCoaIi/kmM6x6aEo7NQZ01CfrVjdGooMVdk/1u/URnsbwombS5xYa/qd2q
         wUClar+VK81AvmchIH5hwI8kA1yJSsfqSFvM64JzJKMwoKGNWwHAy8EnOkqwtTLDtIMs
         DzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596008; x=1791200808;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
        b=dwuxt3WLcLOa8jpc6YvdMdZLB10OeYEIuTcws3A4wwG6MljaefcCnhfxlvsfs50wol
         J/sunZssLVOy+ZnaMUuhhx/SLdbhkAfJT7WLJhuDV5UHE2W1CgNnk73W851TTxq/64mA
         SQHmdUgy1I5lJKnnmzP8Jz8lF9B6sEUQsSqKovxRDo7UrKl9XVml8ZPnKILvnsOqyhc7
         75hoXR4qEXTXOX8aZI+iv6C+Kz6vmdWpzGh89qhIuqEC2eokP03jpBlmRKdtZ4rUgvty
         kd8mwgXcVW7OikjYVBuZhIa2TP8yoOC5OpN8toV6Gp9tPjFjEpzUAxqjgFrAB6O4OBKI
         oaQw==
X-Forwarded-Encrypted: i=1; AKwUvBwRZNyLV8bLLMr1fWqJmMqiuKZ6Lo05bYIoIUYb90lXJ1tuxmIyI9gXbf9Rd5EhZtKSRt3cWnvrBUiMxc3Yvw==@lists.linux.dev
X-Gm-Message-State: AFuF++mXtOV0RxAFKenrJlZlswU+1wUn28aY8FSjjVy2eyN5pUD2ua6Z
	aNE6IgCMHZkMUndHGN3ctviNMJMHrDQYQvm9Syg42y/ucb6+gNFpPl/QERkxgZ8xJez9xrbGAYL
	dj2tQyNaYljR945CfFSgIKbavQu9DVp0=
X-Gm-Gg: AYBFou27WGUMunmHVKRS5HWN3Grq2V2z6LQynyNHiIEY9Nwt5Y5z0z5sf6R/O13ao7w
	YinrVJ+vJDhvt+EypMg25Yukfo7YgkqqesTYiZCbj73E3jEEVZHxkqyC4pOLCNbL/QswqyzUz59
	omG2HdgzqUicYI1muW17bnTPRjK74T9a0Z7mxwAymK4NrkPUyz2jY24Ve458+SwCaG8JS2c8DmZ
	SMpAM2d/NWPFJboWzZaAJNs5GwIvW028+Kg/j5e4yQG3HfMVPvU1iBsuHDQz+WjvmopdL07JiB7
	tUtNvInL0eWZ2F8ohLFFNbvuq5z7eI8LSvQg+jESYaTPN9jkLfACE4uJYtt8SS8E67Y8LDEgo0g
	+SQSmf2kS4w==
X-Received: by 2002:a05:6808:bcc:b0:4b3:7da2:f393 with SMTP id
 5614622812f47-4d72c636b6cmr12794285b6e.15.1790596008135; Mon, 28 Sep 2026
 04:46:48 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:47 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:47 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 13:46:47 +0200
X-Gm-Features: AclHuK8vvWWUjI-1FK5rP_VlhGDEQ4c_Oaxo0Aq7l7qcc2S08USGBF3bm-pvFn0
Message-ID: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
Subject: [PATCH 0/2] HID: picolcd: Fix output-request and framebuffer locking
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, bigeasy@linutronix.de, 
	linux-rt-devel@lists.linux.dev, deller@gmx.de, simona@ffwll.ch, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

This series fixes two PicoLCD locking problems. The first moves output
requests into sleepable context and serializes LED state updates. The
second breaks the last-close/deferred-worker lock dependency using a
private framebuffer update mutex.

The first patch was tested separately with the original syzkaller C
reproducer and bounded concurrent sysfs/UHID-destroy workloads on
PREEMPT_RT. The complete series additionally passed repeated framebuffer
open/write/close and persistent-open framebuffer tests. Pre-fix modules
reproduced the respective failures. Physical hardware, prolonged stress
and suspend/resume have not been tested.

Patch 2's Fixes tag identifies the fbdev change that began draining
deferred work from fb_release() while holding info->lock. Patch 1's Fixes
tag was checked against the upstream transport-conversion diff.

Aveline Noir (2):
  HID: picolcd: Move output requests out of spinlocked sections
  HID: picolcd: Avoid framebuffer last-close deadlock

 drivers/hid/hid-picolcd.h           |  4 +++
 drivers/hid/hid-picolcd_backlight.c |  7 ++--
 drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
 drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
 drivers/hid/hid-picolcd_lcd.c       |  7 ++--
 drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
 6 files changed, 93 insertions(+), 58 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0
