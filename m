Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A2375AB5
	for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780269478; cv=none; b=PyNSDEDxR8xjrDyvMwDbukbdI0OtA10kj4koUNVJ9yZR4WlKSG0waXqI2jOXx4fP06zq8tQXhRvA2cN+FeWPRam+a19thWllrVbWC34ol7xw8kSDC4RdMj+8Tn1sAO+5yYeJ7g8QaYUgn89tSs4aUk5SQeGJn7YqQBTe+jdSxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780269478; c=relaxed/simple;
	bh=P5OF0xm/mrka6NiH8mLXOVcDYW5VpWJ664tJff57hhw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NLhy6cCgxeVEJC8DKVZzsgmpKLHbUtVVZSUDHDCKinZXEqJtyOkYf1WVeKi3DPxoFlq7Uq91HMDHk6UeW16BV3/5ABrXzJBeuEEzwM8Xe2Va/dy3toWUz3NPtRGtpxwZkwwREAMV/qBSkuc7tSbNl36A5AouEmjuzsDM9emX2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=j78ZNbSV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="j78ZNbSV"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef616daf6so2083636f8f.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 16:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1780269473; x=1780874273; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvVfxmpNQG/L7irzhFPgpD1+Jj3XJwtNjmfXwxZzw3k=;
        b=j78ZNbSVyJe8foKLIxw/ELaDZ/E1NmDIsDt/hZJEWTQct8nUCydf37SgbZENAhQau3
         g5/Ydv/TmQ39bv1Sydh90cKbAARzlT4TzecdGnYaObcOgAS4dKzfLIVOfOvtO88E6UVP
         a1s7ACZErIXGFDThQKFwk8yDzAjcR7v32/QjBqgSqaWats9PHLU3AMuB2P9QbAk+4mMU
         SOOgi1a/hZ17wu61VkP87CEkVtsGEAOLvZk2oTY+IHYQwE65fHntTFesxixTePdzSQyl
         Fg1Y4vZUcRUiSAeqYT/2hrk5a+FOAwqdL4HJG/apuE10/tM2mvDKJj0T3vtjxJyajtgn
         e6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780269473; x=1780874273;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvVfxmpNQG/L7irzhFPgpD1+Jj3XJwtNjmfXwxZzw3k=;
        b=THhxa76CVOnz/mlw1CL7WTP115BloD2GZDTDD8wteGhczIjI5hSKsBnCEXl7Qx6rNZ
         oGynnKzER3fsAmwuCkxKgD3eSBIxnJYxm3b7eBwXvbKch7LDV0fKPibiKl8GCK7RcuZ8
         r4x0FelqzkzmojdTmN9/10jb/Rt1CGzAjoomu+Uu2Id2wEqR5vqJ2dK1TZpHMey+qKOu
         coEXq8MAUQEeS/v0umPkFa4fik4ArmdV3I93UrtOjrVCnBS/dduhGqz5AkfV4oAhlwj+
         wbjuSETtkq4HRVpOLnERYlKM2Ls0Pdv7i+664D8OaTirw4F3V3m/CEu1aNwf4hBwVyk9
         cGqg==
X-Forwarded-Encrypted: i=1; AFNElJ8i4EN5hu3LcPfxEMd9e+rfAhRd9/lVcbNWu6ahOIzRS7bCyjx9sD7l4UTk999BQhPqvSKh1cyAiGdjpTK+iA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqtBpJUYkZGGdOis/eZaS+5LaGXSsZhbuO1koyAKWpcHYdKRfQ
	oqfBNdMKkBarDC/LWWEQpeg3bhkqVY8ssQQbhlHv0C1swjVIW9oVwt5zd4/kZ6sFreo=
X-Gm-Gg: Acq92OHtgxUgunjcrLaCED/iqTbY77kg8W+6STCwrk9i3s+qNh/11D8ss+w5covP31+
	IYLv5rlhK6lGBD8cynWsx+3wsQiEFH0f2hjWMU++wXusPfsmAU+tDr9SvgV4datdpr+od432RnU
	bCUC8JH6QnCj86xxYVt3qMfCmWPzMnr6H/GzRy3sJ/sHt/DswlOS+wAOZRARnz2QhgrtkG/q5m1
	JL4KIScWzWa0m+MN/BSmh/QA8qB3fr6MP/unofDnGK7U2hp3HuLIZm/nfNGqELecBT33pb0LEWn
	+ijO1vB1xR03zVqWyXPIa9HboeTbmD/n8gdszEoeSLFp83N8VMCOZ1tZ1gws+i3qpMhZine8MgV
	lRmNvakbPfrtJp6bZBveTdMX4sELA7njD0c4gkGO4TFjnJoSlE64hRapwrXjPo1Mmc3sepLFx1y
	lN+OaQ0bBVU/IYjTTKZ9Hk0YiDEphjBMCj+eHR52VZrL+w0cIofhO2EneIZ3MI0nf7udqWW/bXn
	kkMakS8CpUjTtUhs2XfRRMLiCyQvZLtR6hJ9Fv2dY9hjJhMIg==
X-Received: by 2002:a05:6000:22c7:b0:452:c246:ab69 with SMTP id ffacd0b85a97d-45ef6b19d61mr16050820f8f.13.1780269473022;
        Sun, 31 May 2026 16:17:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b834esm20496544f8f.11.2026.05.31.16.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:17:52 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH RFC 0/4] printk: nbcon: deprecate boot_delay in favour of
 printk_delay
Date: Mon, 01 Jun 2026 00:17:36 +0100
Message-Id: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJHBHGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NT3ZTUgqLU5MSS1Pik/PyS+JTUnMRKXXMjU0OzlERjCxPTRCWgVqC
 StMwKsLHRSkFuzkqxtbUAVnWPGWsAAAA=
X-Change-ID: 20260515-deprecate_boot_delay-72516da3845a
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780269471; l=3561;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=P5OF0xm/mrka6NiH8mLXOVcDYW5VpWJ664tJff57hhw=;
 b=jd4BdPXOYhA5C3VuBpHOxuYvDhRxj3UK3/Zy+o2fPRXdYrjLtNEoXK00YciKDgId74ES5IXcP
 mZ0yIKI8+zZAjR7XEjXvu4nEGfHk/dmjZPVgChukvcpwwrhQBkk/QyX
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay
sysctl are two distinct mechanisms for providing similar functionality
which add a delay prior to each printed printk message.

boot_delay provides a kernel parameter for delaying printk output from
kernel start through to boot (SYSTEM_RUNNING), whereas printk_delay is
configurable only via sysctl and thus is only used post boot.

However, since the introduction of nbcon and the legacy printer thread
for PREEMPT_RT kernels, printk records are now emited to the console
asynchronously to the caller of printk. Thus, any printk delay added by
boot_delay/printk_delay continues to slow down the calling process but
may not have any impact to the rate in which records are emited to the
console, especially for slow consoles.

To address these issues, let's deprecate boot_delay, extend printk_delay
to be useable from kernel start and ensure that delays occur at the point
where console messages are printed rather than queued.

Please note that this patchset results in delays occuring after a message
is printed rather than, as it is now, before.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
Please see the following related work for additional context:

- https://lore.kernel.org/all/20260503214214.3475670-1-rdunlap@infradead.org/
- https://lore.kernel.org/all/20260505-printk_delay-v1-1-5dba51d7f17c@thegoodpenguin.co.uk/

I've marked this as RFC as I haven't performed sufficient testing on nbcon
and I'm keen for feedback on the delays added to nbcon...

nbcon_emit_next_record describes @wctxt->ctxt.backlog as an indicator of
pending records in the ringbuffer. This is then later used by nbcon_emit_one
where a comment suggests '[returns] True, when a record has been printed and
there are still pending records.'. It's callers then use this to determine
if they should continue around their loops for another attempt at printing.
However, backlog is the return value from printk_get_next_message, which
returns true if the requested record was obtained, rather than an indication
that there are additional records beyond the one about to be printed.

For this work, I needed to know if a message was printed to the console, as
far as I can tell, if nbcon_emit_next_record returns true, then it indicates
that it still has context, and if it does, then if backlog is false there were no
messages to print, if backlog was true then a message was either printed or
suppressed. Therefore I used wctxt.len to determine if the message was suppressed
or not as printk_get_next_message will not the length accordinly.

---
Andrew Murray (4):
      printk: remove BOOT_PRINTK_DELAY config option
      printk: deprecate boot_delay in favour of printk_delay
      printk: nbcon: move printk_delay to console emiting code
      Documentation/kernel-parameters: add/update printk_delay/boot_delay

 Documentation/admin-guide/kernel-parameters.txt | 31 ++++++++--
 arch/arm/configs/bcm2835_defconfig              |  1 -
 include/linux/printk.h                          |  4 ++
 kernel/printk/nbcon.c                           | 13 +++-
 kernel/printk/printk.c                          | 82 +++++++++++++++----------
 lib/Kconfig.debug                               | 18 ------
 6 files changed, 93 insertions(+), 56 deletions(-)
---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260515-deprecate_boot_delay-72516da3845a

Best regards,
-- 
Andrew Murray <amurray@thegoodpenguin.co.uk>

