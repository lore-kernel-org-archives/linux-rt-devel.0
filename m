Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D23C4B83
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837372; cv=none; b=G/z1MHjj7aZ6/x9dg5qkWjZje+B9fcCYNcp5sj3ERyB7EV3Gs3G23AOYm1NkaUcmBXQlnTImCTTrNbTKE5MfjP9QMjinybcofm37U0x7V5S8jl800IP1IDl9hR1lSe1+UGCGQWm0Ca8DiY+niApcNifOahz+9jno9ePikgH4pMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837372; c=relaxed/simple;
	bh=ySXKBmJ/U8bqVEuShkxwbboi3HlloriRk6YpRGniIko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SJ/jt1yCcA4VHigHjUAuJ9k1lreZE8DBLnYapnrAQaNKhr7FyDidOTxJla9ngQNT+M+SLDuTTZ5bCNRek81cR+YfdXmoTwb48RIU3OS74TkvST4QJLk4poCzDXwY9zNAiIB2z0qHeQ1fpG7uj6d6RV5rpeStD9P4Zj13g0lS42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=rd5ToozE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="rd5ToozE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4924593f45dso59959705e9.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1782837367; x=1783442167; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlOvwkoIjqQ3dyIBe+7i8C6OqBUbb4KmOF29Y6QRtEg=;
        b=rd5ToozE5CVG9RxoNkjbb5LuvOcILWwfCuNcGE1jtult8CxvY+gdjjPqG07x6Ukxc2
         No6nIjFb4SZffYS6jZOYAXF2vxRmAwpbR+6aZrSAs2FYYkPtm2eNVk7A8riO3yg7RVW/
         S2TXhSmpZBB1clTBbBipHh63slp+14j5ezaP60Yi/mPDqtDJKr4v7RIIv31Mv63vOHuA
         1hFE76ph4vNzVWI8yq0yUaEhTi+IyYyzAcflTkdMpFYnRm3qakkao5vWWyYinP5trTHi
         OMxqEJu5byM6OQDsAvDNMOY+dN60anl0//lB3aF+fGTxKd72M6HAMdpgSKrORlP7BK2g
         Hiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837367; x=1783442167;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlOvwkoIjqQ3dyIBe+7i8C6OqBUbb4KmOF29Y6QRtEg=;
        b=LysJ8WUdtsMdc25hm6rkNk1hNL9Q5rv7APiSNXrS9dTmKdJU6Joc3Z3MEcWaZpx30H
         3PB0BY/hf9i3H6AufHhdYy+C8faY3uPPcCYNMWLSaaukm+ECilu4reOP6r5qxNtr88xV
         39S3b76jkAH1nKWs3AnoAmUmwVQtU2N9XRA1A2KiY63j9GHqbpjA1R4pnl9P8r3Ku+DI
         Ec9ymvajMoaoh8N45DRXqM/mncKApixII6b7yNR9HIQTEzGQaxas5TqtnqtepffKiB9g
         ags6zBxTVPVrNh8VNETdPPK3ePOhytxHoeNgeW4iEuAllcndNIqfe8x3iPVk0w9mM7y4
         etXw==
X-Forwarded-Encrypted: i=1; AFNElJ84sVmX7TxL6JQvGZE5zLYP5ETB7F9voPvNmfmW8lwg/5+ec2BQctvT7j/2NUId/wjLMiku6w4N916T51xnsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEzCoyFazq7qEv+B8TB3jQH5IIhQc/MQ7QvfD8HJ5T2m5/7eVt
	ioQUQFfTiWJuH97RRiLtvYP8GOxsD2DnsIN8Js4sdfoUk63kJayQryzNxDY3SzVI76I=
X-Gm-Gg: AfdE7clQ0PCTsHrmG7wlF1GEMCrSs1Flrjs1UeJypjLHTMXuTImTcZP3yq/XMkb5SGL
	+rHCThiCUqjEYJtnIRSLaU/if8o35M3aQQ+R/UCXRzWvnhL0yL+fFhb575bP/h8Gi++StiCYp53
	iUuPZIj+BYTQ+vSbQtxXNENDSc9eH1xpG4DAPrgt00KCiZU2FedG8GtOA0++tQnGsKUlKXCG9Ga
	4/9dFJXsuKCeUgetT/nZN0nr5pi3WsSjcS11YvB5b03OURUpni2C0Nu/hrw7ZbjTFkNxGpjAIZo
	AMzQNiHcGbPOPJPwL0chs94ZZZ8XDsSuTDqTozrmHJevM09EIwdTCii8HyUND5kOQsFt4tefCWq
	dKtvMvpNNupoptSSWYXFDQ2T1sfGp7hDM06vHyIu7+KJOI6hWUK6I8fWwurSkzWKht8/wexBTuw
	ze0codIOK43FAkCHaelQuVplhA/Lt4ncDAmziTbk0p4zPeyKHVwVMmLuBlsMbrvtejKXtEBj6co
	gz2pIHw+01YtO08lkK8gvlKY+RV
X-Received: by 2002:a05:600c:c16e:b0:493:b87c:c87d with SMTP id 5b1f17b1804b1-493bda41fc3mr20284025e9.11.1782837367139;
        Tue, 30 Jun 2026 09:36:07 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be486f52sm8452225e9.0.2026.06.30.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:36:06 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH v2 0/4] printk: nbcon: deprecate boot_delay in favour of
 printk_delay
Date: Tue, 30 Jun 2026 17:35:56 +0100
Message-Id: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGzwQ2oC/22NQQ6DIBREr2JYFwMoaLryHo0xFH71pw0YQFNjv
 Hup3Xb5JjNvdhIhIERyLXYSYMWI3mUQl4KYSbsRKNrMRDChmOSSWpgDGJ1guHufBgsvvdFGSK6
 srtpaapKnufLA96m99ZknjMmH7XxZ+Tf9CRXj/4Urp4yaqja8bXgttOrSBKP3dgY3LuhK48vlS
 frjOD4CEMX/wwAAAA==
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
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782837365; l=3474;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=ySXKBmJ/U8bqVEuShkxwbboi3HlloriRk6YpRGniIko=;
 b=O86itWXgtpUvHd6jHgcUSDYONHr8uM4FtjVKgxr5nMaMcbfYVqTugJVOlYcUmoahEOOuQHZO+
 MNX9KPA/fAIAGn9TedwW6ewrNcoYK9JZHvG/qKvgLYQ/JtsDREPeuXO
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
- https://lore.kernel.org/r/20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk (v1)

---
Changes in v2:
- Rebased onto v7.2-rc1
- Correctly handle negative values for printk_delay_msec (patch 2)
- Add missing newline in pr_warn (patch 2)
- Improved patch descriptions for (patches 2 and 3)
- Use new emitted flag in nbcon_context/nbcon_write_context in place of backlog && wctxt.len checks (patch 3)
- Use unsigned char for unsafe_takeover field instead of bool in nbcon_write_context (patch 3)
- Move printk_delay_msec and printk_delay from printk.h to internal.h (patch 3)
- Revert regression added in v1 to __nbcon_atomic_flush_pending_con (patch 3)
- Move printk_delay later in console_emit_next_record ensuring delay is always after emit (across nbcon/legacy) (patch 3)
- Fixed typo in documentation s/boot_delay/printk_delay/g in printk_delay= section (patch 4)
- Link to v1: https://lore.kernel.org/r/20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk

---
Andrew Murray (4):
      printk: remove BOOT_PRINTK_DELAY config option
      printk: deprecate boot_delay in favour of printk_delay
      printk: nbcon: move printk_delay to console emiting code
      Documentation/kernel-parameters: add/update printk_delay/boot_delay

 Documentation/admin-guide/kernel-parameters.txt | 31 +++++++--
 arch/arm/configs/bcm2835_defconfig              |  1 -
 include/linux/console.h                         |  5 +-
 include/linux/printk.h                          |  1 -
 kernel/printk/internal.h                        |  6 ++
 kernel/printk/nbcon.c                           | 13 ++++
 kernel/printk/printk.c                          | 84 +++++++++++++++----------
 lib/Kconfig.debug                               | 18 ------
 8 files changed, 101 insertions(+), 58 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260515-deprecate_boot_delay-72516da3845a

Best regards,
-- 
Andrew Murray <amurray@thegoodpenguin.co.uk>

