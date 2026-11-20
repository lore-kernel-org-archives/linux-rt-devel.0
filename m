Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137111;
	b=KflWQ3o3aqxIbf2RX/FcYVzrUEAfJ6rJuQjVPAe+YBX0GJHy+zbOHKUzlMVTYsuiAJEr
	 vzWUPFHYmfrNLYi1dK9VUTPQORE+PcpwDuts6HSb6Q96cTvcjQ0qR8EkmQZfM7GHefFTk
	 XvLxhYoBQnwV9542e3y5o9WYoqoEZD8HdongyLzGBA4EB0DlgRtpG7f8+KBATAKvcX0hv
	 VAQvDenBRnOj7gAnhlRzzJG+aVeV4PXJVZHieErRZWyFrXnSXNtSWXUyR3Tm61qRcjpla
	 sXPiQLZXzV6MVLXrq4Jeb+Z+wgUWn00c/j1bVuTGCNtvmu36/Ub582GokaAm+s6dyRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
	b=p0Js1fEZTu3+qyx2JnKtOUg+9Z9FedYFxcAl8Z159MzMcMJDaf7CIDc0toU7G6Aa+5y4
	 7mUWIMO6bWTnUqahb9Vy4YHNthZ9qki/q7lhTxcncnYgX39VMgB9c5qcQi6yQEU54w/Wi
	 8jEXQ3YnZtmI77mYibIqajaEjAjnMmBWe4yFDXWRa64eEr+1UhyxTdlqupp4yvuFlaDiV
	 ewQOfQFXRZ/8Po46Dqn1KeJkhH1bXum4emRYfiWZXVPAuneplvZPi3k+u0EmlgZiGDk5d
	 Wahx/IoR7ikcTXmliiqBOCqmd/ivfzAGOwBnbiLtE4WPp8O/37EG/tlJLxvlpfR/9xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tvYHNPW8;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EC4606A32C
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 01:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70EC4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tvYHNPW8
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3b18c01238eso104445a91.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795137111; x=1795741911; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
        b=tvYHNPW8o5V7ghrZepr4aKxGTcLz/xlKjXj9eiNSVruUj+RA7CvSk39zjQqbnwXKEk
         lgH6+vPO5kNGr8YkFhx45zxqLDwI+03KudGH5WZyOOL3thEm22DHgVi9dQhp74VDG3zh
         SxQMe+OZ1fUyOzbuhi/2slvp5fjE7A/HgQJgk0R+y4NJ8ycIhkJMplrlVoxohpMBqAwy
         CLxeSJzCSDYQDb71WGiIlnuQDlkKI33HlNkgY9vLmLFN3ciwNLqmfJLJkvNRl7Mehayj
         eLFt3jk90FDv0b/Q5Li+70FfQoMjg9robzX3T7SjCP5NTOG5AOgBuFpJWU/7nvdjEtk0
         HNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137111; x=1795741911;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
        b=pMzlbSSf4Y3FsVn6iQkAMv+FApfzLZpnjX4hp4E9IzomqWg6LF/RSuvUzbxKdzCcro
         pbSEyCDyjQXGP/O8Ge/WrGHuVUfAKHqYChaeDYDyUN9pGa0sGG0PXa4gfCwvktajsDyc
         HK3c0tZKHhfO55qkUE44fRfEjZ9/H3POexI22WC/oNNOhhWFuIeHusT7cXjuApja27+q
         oGcIyDsgPdcyajA8b6JgNaQFUFCY8KZ0loAzbHfHUCQ6QxgGxPJynBzDE5m45G/pEU+O
         NnEHA6xr2RpC/OrvkgR6JMTWpkvfA9Agpy1cqjj+SJwLt9zGgulGXH0MDzU/GI9UbtNP
         iNsQ==
X-Forwarded-Encrypted: i=1; AL+hErEqYWS1ys5BXCEaNuQ8ds/YadFaOoqEq0uEi6aW3qXQlTJCTTYzZFhoZsC1qKVExFBo0vQDLOdrIm9745RHfA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/gmbqmlrPTMKW2oerQBMSqg0/r9wY7i+UDXXHLaSllYLaf0mIK
	IQLGSeHzFXy6bePXdAAuQN0tcHMpClR0EuG376nYdq9d9EMh9WN09i89
X-Gm-Gg: AZFdTZd6XipRSMWgFs8zxuWZr8J0/knJYbmhDTRH5r2ythJHusjTqQ8u3u7TDUlbxKj
	NridP4xVUiQ6RZRJ+YjXojMizJcj2BuEvSVv/gddW5WOPGcqHzK3DaJTxjP0Y0tahpWTwe3qEBW
	ooLyj3iiyjM70xnSbwJ2xWyMIOcXIx+s7hzF2NCQxzrt5X8+gTzAuKRX9rT10wZLi+WQCZlkSlX
	iushPVQtbRa1R/eN2aRmRk+mwBoOLAwtl3jdK661KZuPbrI+Jpm4n3YTUssnp7w6srigTzxo9pk
	1/6j5xSl3Xibk6UoaPSciCgMl4bOw2OUlA2l3hgt4wNqLvfQAZKtQLrApZg2P3T/DUO0Z0M6NKY
	BvzVpkbJDFs3GHHHoDdFA5I+Gs00dqb7b4LoOIHjn9Le3sRTqZwVbdJcsklsqFSQMz17nPgGpJI
	55X9SUQYtrO7LYWra796EvtvMZWLPW2LCwqNinY6RUh7xYIY1lDhYuQ153DsuJmERuyB040b3Ud
	dfy+J1HpFJPSnRx29a3LjaroqESxN8JaIhBX5UKYDvZbiSXiSRQHreegccGLMkBxvjnDAL8hqHG
	hbFkxx+GKYRy/EeXZleZo1SvTOWZkhx05Ilsoisv9DDmoIbq7FMSF8UfFZFP0pwxbYqz6iF8OyW
	BchvzaMs6aKdl
X-Received: by 2002:a17:90b:2f8f:b0:3b3:b0f4:1bf7 with SMTP id 98e67ed59e1d1-3b41c8d460emr1098385a91.23.1795137110648;
        Thu, 19 Nov 2026 17:11:50 -0800 (PST)
Received: from localhost ([50.7.253.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d243eb1sm622215a91.3.2026.11.19.17.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:11:50 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH RESEND v2 0/2] HID: picolcd: Fix output-request and
 framebuffer locking
Date: Fri, 20 Nov 2026 12:05:46 +1100
Message-Id: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNTQvCMBBE/0rZs4tJxCCe7dWDHsVDPla7UtOSa
 BFK/7tJRS8eZ+Yxb4REkSnBthoh0sCJu5CDWlTgGhOuhOxzBiWUllIJvBtusWfXtc7joDBSouD
 xtzvya7PReuWlgPzSR7rwazac4FAf6/0Ozp8+Pe2N3KPcF9KaRGijCa4pVREt/0Uz9bXBNL0Bd
 +SW7MIAAAA=
X-Change-ID: 20261120-mail-picolcd-v2-resend-20261120-ced5a8663d10
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

Hi Jiri,

Thanks for catching that. Both patch emails were line-wrapped in
transit, so I'm resending the full v2 series. The commit messages and
diffs are unchanged. I checked that a copy of patch 1/2 sent to myself
applies cleanly with git am.

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

Helge acked patch 2/2 in the original thread.
https://lore.kernel.org/linux-input/CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=
=3DxkA9acsL9TSQ@mail.gmail.com/

Thanks,
Aveline Noir

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
--=20
2.55.0
