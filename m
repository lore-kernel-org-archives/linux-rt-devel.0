Received: from mail-wr2-f40.google.com (mail-wr2-f40.google.com [74.125.225.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF53630A7
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577776; cv=none; b=X7TsWsTFJAbPoHh/f8l5q/kpixI4R/XBbP2RK3liLJcE8fme60RLsDuwvCUr6a/qvBS+lD+yCZJs/3bTd1tqWm4oUkvxs4iEXYjPxOfMCXx7k7quWdkIXhXZ5TkQ01bwHTUerkUNMh04OmJ82loyJsHXJ/PHNmKg3bKDTxFOO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577776; c=relaxed/simple;
	bh=7MY9g1VCfYcNl1oUjPGni8Xlg1seVgLJlQYJCr77j3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=imG1zllud7pFUgDY++X4QuK9Xmy8RYOJjELQ2YVztzLa1pWQE1wRYON/asbYl022L/8Wo6XgksDUu1QhL3XGgfnQf/CzX9pIeiL2PiyyKtwdmwCgHXLIyMKUClIx56btesEOSsQtj1mIyJrr40h+gufbmWFAtD41mrZRIC3LvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFidGa7F; arc=none smtp.client-ip=74.125.225.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFidGa7F"
Received: by mail-wr2-f40.google.com with SMTP id ffacd0b85a97d-488780459e2so2640961f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 27 Sep 2026 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790577773; x=1791182573; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=knKV+ty7Rl97pUKjME3IBtkaEdWWVK7KKAJhTAdQER8=;
        b=YFidGa7FjFuetqHgTtEw1UR5rzF2gjaJYJmHS/pPFGnShgDsR/thGRSU2+MbrKWT35
         Z+HPYnvYo66snlpw+zzeKZIw5rfFooNjsmvdkeL08wN771ADlCeFLmlpvFIakKzMEGpt
         BipBUDWa+zsQ5ZoiKgQ6LTtxRsnFgi0EJ0kpIp9HjBLg0jmclXM0GNsTV4407gDQ1s62
         GnbqbjT/HnpAC1jBYOPT7krmcT8YifkNa5QCc+dtrMhj4GRkXHWH4xEPcEeGsK465aLp
         UvcGSWpZ8JcLYslIvwJuDuJeux6FJSjh5Xo4peSBM1IthoK6XZO2JDqo1Rze6pslnTnu
         RJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577773; x=1791182573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knKV+ty7Rl97pUKjME3IBtkaEdWWVK7KKAJhTAdQER8=;
        b=xKUOkTqKExfHYxuXPKl0Xcjd+aD3nlwVBQNQz2NJDX3nA5I0Yn0Xs62nWey32M2gdN
         M//bFkpj4Oh7PzuvKTqw56b5Tw7WdU92NKo+ZulCbuDs+9jomqM7ngQzt2fmP8o0XCmJ
         o9QNynnjW76IvIxgz/fjtAz3FcYKPCz0QYejJt4s8zpjT0sB9uRs/oVNvGpe07P6I5A2
         BFU1OI41aMGm2wkrZhjgFe5ECYNGBY41TeNFUZTS/BwIojmPQhiO+qNTlTaQZ47YNLRA
         QBdMXlLYPzSbt70zsDq/pWEJSqAtCTkrJJgl0aK0DuCzpDuXC0FhAYkcnaB6Y0559Hxd
         ZZug==
X-Forwarded-Encrypted: i=1; AKwUvBy6B/Yg1EWRS8jSHes8SPnTqUMSN7nGTGlVonc7KdXqIN+nKRejplI5PVbHSfO90DRh2h+kvSzwYOSzHKuPUQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKwmmWt1lyVN/0mfqSMUbKJbFSg5yUUVx8Fjnxy2MHka4PHMz8t
	cufWVdCuAo6uZ11KpJsXOFmc3ponrGEUNBP+Zm5t+CT+j9e0qB1gH2Tv
X-Gm-Gg: AYBFou2rNP5HXOrYj0dzZP+yfpRYchGa+D2K7iN9kg+wEt7nUYt4iLdazdZdUEx5snj
	BDF+RjqLhdB75SGZ4//11izW5pGUtm+J/aefi5LVe7zBI/uY9jVe00DTh60k2luHx/8a3oVbCdr
	mso1MFDcJLCQ6zJAeTXrz/oVxlGfUTbkgISSOsblFHzTqAVDvO5Lp1hhupq76u+DVkFg8eIMwNX
	Aqxqmv/4ahnwVlk3/5WKZwxlrNl7O3/m2TiO73zhgHxkBFz1d/vJBC8UIBSRq8BMC69EIQWw5Ui
	cj6QtoOEZ74oSTUQTDJtxR5frhtEFhdPjjCeCM8rxX/v0u52ihDEI7GH0zkc9+XBPXJ8dOWdf5B
	y7gmCQ2g7xI9r/SrYgr7Dw1aBQI5EUcy80PvIL9ScxfqOGV01bUJEsVPF/Y1umXSsp7nVqYKmCq
	yMSDRTe4/MXdnTqNdnoW4Zc4F25oQglz/CdqL3yCUBMtdSUmNPzFv3yJZyGElcy+gd9j7xwwwjm
	34hLC6rA2w3c2pvlfZ+vbGEZPp7u1HXx20U021xT8hVBwYAMb58efZHqpQ7ysIRPWtfqmHNmjVv
	I6CzTcmYA6dvEPqp8ND/BROW6vd1XrdrzcpuJWeDoqxrImUv535RhCNQKyn4rdFeKgRraYtUoeZ
	TH/lnAg==
X-Received: by 2002:a5d:5f49:0:b0:487:490:8391 with SMTP id ffacd0b85a97d-488717252c4mr22421127f8f.16.1790577773176;
        Sun, 27 Sep 2026 23:42:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm26283196f8f.4.2026.09.27.23.42.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 23:42:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 0/2] netpoll: fix PREEMPT_RT deferred transmit locking
Date: Mon, 28 Sep 2026 08:42:37 +0200
Message-Id: <20260928064239.32456-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll's deferred transmit path can acquire two sleeping locks with hard
interrupts disabled on PREEMPT_RT. One is the sk_buff_head lock used by
the sender and worker. The other is the device transmit lock used by the
worker. They produce independent atomic-sleep reports.

Patch 1 gives the deferred skb queue a dedicated raw lock.

Patch 2 makes the worker try the device transmit lock and defer the skb
again when the lock is busy. It uses the queue helper added by patch 1.

Testing:

- Arm64 and x86_64 PREEMPT_RT W=1 builds passed.
- An unpatched Pi 400 emitted the queue-lock report five times during a
  one-hour run. Ten boots with the complete fix passed, including one
  3,606-second run. Every trigger and post-trigger marker arrived, Wi-Fi
  remained usable, and neither atomic-sleep warning occurred.
- An arm64 PREEMPT_RT QEMU control reproduced both warnings under forced
  transmit backpressure. Three boots with the complete fix passed.
- An x86_64 QEMU control reproduced the queue-lock warning on PREEMPT_RT.
  Three fixed RT boots passed. The non-RT control and treatment each
  passed three boots.

Karl Mehltretter (2):
  netpoll: use a raw lock for the deferred transmit queue
  netpoll: avoid blocking on the transmit lock in queue_process

 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 83 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 7 deletions(-)


base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.53.0
