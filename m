Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA62D8391
	for <linux-rt-devel@lists.linux.dev>; Sun, 19 Jul 2026 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784442991; cv=none; b=oMB5GrXpVn28ggXtdmq0cqb9pCO4UNmodnKUodpXaIqelScp5wnTjWZv191OgnnsiaOFOBH4zlAlNLpaZ+p09Ah/L8g0pF+QtdMItyruhklLXHEG12soKFMlNBf8Mv3daJZ5Ym16ueO3hjZAQqNo2VdBdlJhiSERHoHzONw/OKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784442991; c=relaxed/simple;
	bh=3cHYNNdF0JxPczIb6stDSck7qiEQvP2yK54kglp0nTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5SRcluVBOyt2m8VnzJWWfWe1obzok6MVryC6XW6USehQZGBOFE/vEflxn8UDIBVZ0v+qt4XhBHnZQRqMgG+A3phZ7KevgQEzF0ExVTwpw6GkJZoVpzFxNCqo5IjpoJYBmQceVdqkTeFqUgOSMqCpbMvTg35sEE52Z+l8BO3q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKbBkFs5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKbBkFs5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49546c690ffso18900635e9.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 18 Jul 2026 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784442988; x=1785047788; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGAR8aGiBoBWo964VuxC9unxOU3E2crPFC6OtuASy+A=;
        b=kKbBkFs5Z/lpdpFypZmabfRvWmusFIPGoLBsDRtK6e7EeIFpAT/tBKllbtnuDsIoMN
         upPmL/KVVTx5stjjbEcm29mrQuxEw0tK4t8WrFadYoMQuY6ajffn5imKyLUFZCH5IIgl
         FxmU363LYmZFbNX64gvJM4h97WAdhet1K5frV2YLm+D6a+ZKSUlKJK7Rd3JGFs150lK/
         aJlAdyNybtIZqjNFd8ssraq4URRfgyg75B+XonbWIj6yV2H+9cayH4bw1XrQEeSXr6ct
         kJjvSwvE0lQaPI0OiTXY8TtRY+Jg3vBhwz86gejdCNvqYNgBFHkxJWmorJAg1a8adnNS
         UuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784442988; x=1785047788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGAR8aGiBoBWo964VuxC9unxOU3E2crPFC6OtuASy+A=;
        b=nubokWSDbnLJ9eyer8EBirtjRErPHb9q3RtWX/ntu3DP+PB7wpVW8+gAGY3kpogAtJ
         xuwkkgBzn66sCzVDqddovhwwyIVLg5xvdkZiJLvPpip30Bja/lxKf0nCbx18tHEmTuGM
         GxEfxk/Ua42gN2oWSP0hsxuIcTiooQHHMaKLatEdlWHj89j6S/P54JLKKop5+9aeWu0j
         GIb10COmf//+CA2NsYyK2m8/8Cqfh+XgeafpT3KnSQhm708NI50ZRpvjYJH33dkMky6U
         e6s3M0pGgp/vJAa+w8k+0lytx3eU2eseugq1f+LJ3zf0wuu+F3BswsX9wh5iTD+s/HvR
         8wrw==
X-Forwarded-Encrypted: i=1; AHgh+RqmOcBaqc/EZbvduxBMqXt87bTKUU7T50eWuMzaJ3QBca3nL0lq1+9R0QykloGzr7WRAq+MRuKUogJJyqUXkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXvDgMESkJGrITxUz4expxiGASr3WqB2OKutr8Ww3tVfDg8HQw
	u3ZYYiQz8xjVPOpUYPuF9H04E7pMcRm2zE88nmgIVSUUk6IpY2ZAishu
X-Gm-Gg: AfdE7cmwsxuhQDEp0QaQNXlpgeLXSruZZ2P3Gb/awJ3m+6LUAQIBLm72K5jwELGHmTw
	1AYdbBw/wXL/Le6JhqtCYk6r6B0tI6vCkhBgfKgr0CC2C4lj1ShdZ9ZUl3ydvGM7szr68EeLF6/
	0gnTI96CYyc4NelP2uHLXx+R8Ut2jx+0XJE/HPHCEAsLBAxl0rcLX9ewBU5IB0ylyKk9Zex1tvZ
	W29GQciKm9UaYPsVmbVwEMTUPrmFs6cmiL8b07PRAeWJnXmDkGAiv7DvJi/rhb4fX5OFIwnE7c9
	OORvMGXFLWy78F6qcEAyoTaZNGGPP1yG5GCwbevSY4WqZjg/yBBeE8vjR4DJdtcsh2DccHDoCoa
	pO6DtX7TkvdDcFeMjCf1pCDvJEf2EM49FsoQFPD1WDDSs/QJsQI3Lmj1L++xgPeriO7bU5rYSPN
	nIs111mCemhJ4Fg0Y69NBmHa6pajl2k+S34gTp0CJ+4wdqyZApr2LE8DeSduj8WgNXlKlCPKx1W
	C2PEhz7eVx1UTMYlG0c1EpXL7N7rP5WQWP+Idc=
X-Received: by 2002:a05:600c:4e94:b0:495:571e:e5d3 with SMTP id 5b1f17b1804b1-495571ee75fmr23066555e9.36.1784442988176;
        Sat, 18 Jul 2026 23:36:28 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-018-194.77.7.pool.telefonica.de. [77.7.18.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96f19sm193053245e9.9.2026.07.18.23.36.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 23:36:27 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 0/2] serial: amba-pl011: fix console clock lifetime
Date: Sun, 19 Jul 2026 08:35:00 +0200
Message-Id: <20260719063502.18852-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes an independent bug: pl011_console_setup() prepares the UART
clock but nothing releases it when the console is unregistered, so the
clock's prepare count leaks one reference per registration cycle (via
the sysfs "console" attribute or a driver unbind). It adds the missing
console .exit() and stands on its own.

Patch 2 fixes a PREEMPT_RT failure: pl011_console_write_atomic() runs in
nbcon atomic context but calls clk_enable(), which under RT can acquire a
sleeping lock, so an atomic-context printk on a clk-backed pl011 can hit
"sleeping function called from invalid context". The same lock
acquisition would also be unsafe if write_atomic() is invoked from NMI
context. It keeps the clock enabled while the console is registered and
releases it in .exit(); it depends on patch 1.

Tested on QEMU: the prepare-count leak was reproduced and fixed on
bcm2835 (a gateable CPRMAN UART clock), and the PREEMPT_RT splat was
reproduced and fixed on versatilepb. With the series applied, recycling
the console via the sysfs attribute keeps both the prepare and enable
counts balanced, and the console keeps working after re-registration.

Karl Mehltretter (2):
  serial: amba-pl011: unprepare console clock on unregister
  serial: amba-pl011: keep console clock enabled for atomic writes

 drivers/tty/serial/amba-pl011.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

-- 
2.53.0
