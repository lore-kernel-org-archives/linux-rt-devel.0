Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BC41D108
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.203
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612156; cv=pass; b=TBkG63o/Z0SL/3vzZSfT4w1pPbm4/baxts4R4pi/E6xDnyjXqZYu1LEePFUz8d+MxkVl3kVwHk330Ihv85JH+fN7vtGMd3iO1blAgrBEyrd4PiX5WUYZWeO7xAfBIrbhkw61S06spFXBv1eXRHvo/bS5oGFehCOHKdxZhXF2/WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612156; c=relaxed/simple;
	bh=5zhxTTDmIVJyF7gRnQGI1x1uORVwq6Xhxto6tH0D/wQ=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q6rryRCMqo8UMZfyj1G7HdcGU5WfUq1GjiSJyNwBl8TK5FtNe2X3dmyPTj29bhwLFFFOIXdarpeI1lVumx3JejwGVItFMopiTt8NopmD+rXAWirhUk/iabsu7xbDnoKEWZ5HJAh6RyFVet8n6+WqszTakAGIuqLbG4qqd6xFiaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqIfhARp; arc=pass smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqIfhARp"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4c1e3be1093so1323648b6e.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 09:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612145; cv=none;
        d=google.com; s=arc-20260327;
        b=jattItMxlZu434rgk0W0lmonn1o/lHEzvl/vK9AHaMVcZ8caYjgLNDJjy4KLB99juh
         ANADISEMIDuppUIn3s07ngFn4S5hH7sV3uvmkGcBy670x0EaT3tG9vfm0LNtPilNxwos
         9czUr9QWiCkF2w46jyyQbalLWYOeTxtJYakOsBEgmN8ahqXE1QashWHNBlgFhoXo42JJ
         fQpYJ8w4FbvojhYfcRQ44adBZS8TPxLgVcg/NbRsuZd4HCXSG+B3tTT5PZRpdJyibxEx
         3o8/y81jaubtftFQxg/14mAoEQ9ic/szo632QhbqU1sTb+4Hs+IzmiSFPRZI2taVM6px
         EzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
        fh=oUV7NCMuL8us0sELexYQrWORGzgE2LaZIKWTCQZWTw8=;
        b=ZM4KPmVHpsmOr+kM9nhKHu/pxkKmDBn/gYbzkyaHi2/PGOo8D+vK8XwbWhN0XGxqzb
         /HVlfLFoebxBjJl5Ev3iN2X0tmfW5hL84QIfg9M74DTm+QGQWhGr86+59U/dxNYdPhwI
         HyuhTNRzseiXPPN2BtuTkYLFK09VbF9kXlsD1mWxneSZ8x48w6nyzjhg43XPFZczqtYD
         kOiLT1qBE7snPcH/ppxQzFKhNv40bqoS19QXjEfEDGrEb+qgOOWNA4raUTTv35SY42iW
         3X7+yvwzKB+Jh8gbuOvtPdquCmr9JaVGx+xHWLEPJc+bG+to71ocMJVym70jiqub4jT9
         VHow==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612145; x=1791216945; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
        b=sqIfhARp/8F28uIKT7UMYu/PcuMDRag6B5duXwVmRvjUzCQpElWzocBG8ca9xk6kSs
         +N81/PB+soerI2fyHOiNGA3l8oGDCBoMsajgP8Jy1IbNLU/GBimv4GNzqNNnuHQzBgNT
         Iq5pRJu6H1yNnThEb61r95hq9dOcfdOkN1D55Sufm2OCx3UJdNb0yAEwQK0VQGQIUgaE
         8Rrml65s8i8xG7uxFl5n6hDTkNSY0GZxSMk/PvzUfM7NY1+V0Xe7c+QLjsPaKjd2MWHW
         qJSnGauZzVNZfQ/iPMAYURxa8KJW5Tyb7ZOgBjGA4S57TrUsQzJ8P4t2m+/vP6lrp7Tj
         QY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612145; x=1791216945;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
        b=j/MTY4c9TpKQyI4KBnWyobm06x9Z3kaHrMVUprL89ZeWyR02XezviH9v9wrb3DUAXA
         ZYY4+riCeTG4D2KcHf+sIWkyh+tXNjoQDhMSNgM3RCAhA78Tx+9E687DJ29AsXoMPNPh
         AcEfk6fX/ZtcWBjfHkp3cBfQsu+pJLxx3nPSOL4CTtLDUNqI+iMkq102YknLBbL6EU5p
         VNAoe4QJBsHFgKqNlv3WGWV30Eqnx5QsHKPduew80XfMqr5rpDK9HVvlELFCVfzOkc7Q
         LZ0RXasUVHuqQEs0yoBC7IRJDzY1pciC75IwJYinnvDuYWptrYoWHheVyMqva7NoO2Rr
         RD7Q==
X-Forwarded-Encrypted: i=1; AKwUvByyAZP0RRb2+sfPhxBJHUZEaWArcudAbslD9HeFrmRy+cmbewgdohHQFlySDNonsTmL5+DhO2S7tm15lsD56g==@lists.linux.dev
X-Gm-Message-State: AFuF++lV6BF7Hz0w/npGT3Ss/3jQrDPtYsj/d8RLASxehXWtA1rsxpyM
	BBU371+lCDGnOtSMqtaIaDUEuzIVHS17mEFZESDOlenFb+hGkujqLV5kHkriG+8Yj+uERyCv6Dz
	6evfOPOUaWIZ+H9YzdQBa6WoEDXiRxpw=
X-Gm-Gg: AYBFou3lxA9yUBgN6NQGyIcUiVupEHu46NIohhWHB5EWdnWejUNMADBq/bvaCVtTkXj
	T623acxARfEFm+1rOW+b89kwkUVuitUP4xaikPGqNe55kL0d2Gn2WL0wTfE4iq8f/bq6vV0xfMf
	1awAiJ6ntiXT34APzkpIQNsUCiD8KVRfIWnyyVuY5kH/ZGLQTblLJNcplFJ5vXXcNSqOYsldcO4
	OkpdtRPguCTRyVZB/zd8zGRHSqKD9Aqo2zUFTJjK0DhLnPI4nM5mfMi6/SkkGD+Yfj3ns0rIysa
	R+0acHV/WBGFItgAL1FOCrjqUofMOymTj5r7c2N+R5+Ns24/oj/VYTfgP7LQ4P/dn3hGe+IlY9n
	mw5LYWQhzUw==
X-Received: by 2002:a05:6808:198e:b0:4d6:90f4:48ba with SMTP id
 5614622812f47-4d72ac45eacmr14395634b6e.44.1790612144676; Mon, 28 Sep 2026
 09:15:44 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 18:15:44 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 18:15:44 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 18:15:44 +0200
X-Gm-Features: AclHuK9iPdog26wVV94AzoDOB6Ecnbo54mNzfsBz7HWPWdsxEbSKehYuy5Lt6Js
Message-ID: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
Subject: [PATCH v2 0/2] HID: picolcd: Fix output-request and framebuffer locking
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
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

Changes in v2:
- Address Sebastian Andrzej Siewior's feedback: clarify that the issue
  is not specific to PREEMPT_RT and identify picolcd_data::lock as a
  spinlock_t in patch 1. The code changes are identical to v1.

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
