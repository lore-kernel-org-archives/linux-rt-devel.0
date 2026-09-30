Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB33DDDA1
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796084; cv=none; b=BwTSgUkj8ay71/n3IF3rNcIiHFXWDuvT9tEjWeRvGkT4THlgM3N+R1aTbnicr8ONVE9wooCaSwCtHOL2HtkfbnFshUBzK+evnon8O1Ro/VfhNfw2yM75GSDfjC8KRbBlO+6DqJcTw3UaoHXQpk0Sx1N4IXheu5FXMoOeIpv56Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796084; c=relaxed/simple;
	bh=OaywG8qV2zmeQmYflGw/QkJAGzejff4a8mMmROTwgrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZiWot+va8PQZfHksAzuWg48PL1Q13bftFVNbM8p3UUkhyUlDKFEPKqzMWrtoJA89cwIw/xPN1SBCjkHIoq2KRTTSXhySekWPAgUb5QfBUUXdk6WIln+CY3WHv+u7BQe8SDpdxUVc2TtQSVybS+K0+Xer1Eotgk6WCYo0SCurjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb8sVHFy; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb8sVHFy"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a00713639cso27790085e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796081; x=1791400881; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iy6PlywfDUA0Eh+zmjEhhc7NS3KUQphzxgwcZvfITKA=;
        b=Eb8sVHFy03CLCXlzO1f2Te2n0Oslg/LV4faLrh/fQJIp7tBaI+Fls3vaH5Ec9ijYQ0
         +27RyABhWJWnIBGXouH/w0G/JThWP8Sk2dzBgWM+0xVgh8VfFtWahVsg1kU3W6Gbtjln
         9gbpzl3NtB8H/KiITOj8vdNPFBpBgXwKfN3h4Xq8F5jYB/KTpMrYk8iPzotWiG5eZUxl
         HkZtqayA29LjNwhYzvFzDUp3SxhgkVxNbHon624M1hD+B+LZlw+O5yZawe7DX0NCOTIi
         xG4JMDu8kAI40Cp/GOflg5lZ+Sjp4ADbkDSzA/tkfSXIIrPpGUKMcO17HVZpzqeJgNVt
         m3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796081; x=1791400881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iy6PlywfDUA0Eh+zmjEhhc7NS3KUQphzxgwcZvfITKA=;
        b=UhpC8T5VsOg90ZlvkNtg+X9CmPqj+17c3dp6AFDm5KGR2fkpzbdHUdkSb0kEhA1WCe
         6myaByGHajy2zsbgQAyzzlA0Nhr3DEZio/Tf2Vnlr4JZioaTwy66aJDYjJwazeNimvCf
         9yTm4zgcGrc21ZbvL24Ltorx+/0cPNHZVqcBpg1blg2RoFwcDO/yCXVCSVipOILxgXYV
         0BCisWql4uC4xTfvbmCsmWBF0vsE6Ldngetmx17EHtpN2dMICkax6i4YbpD48I1tFeMx
         L9tioOHF/YHYzhaZPrz9kcU3HPvwm50D6nqyBLXCkHgydYxxmtFKNgEkt88jmNFYOVbY
         Td3g==
X-Forwarded-Encrypted: i=1; AKwUvBwSJmxHSTdtOpS+lvmBIQPlvfET/bVuW1PJA2CUXx6ingx8uOoNOJFVoqKAbxDxNuvFXa72ub6YzGc7C6sJ6g==@lists.linux.dev
X-Gm-Message-State: AFuF++nn0oqTxApHPLBfOTtw5Tz8R65yYYpfUgPPUOMGGNeBFYCww5X/
	Lyj+IAWueh6bZX92YbmN/sMCNX2meW5O/1I5OUbJvPSrvGDckWpKfRBS
X-Gm-Gg: AYBFou2j38BaEg1omyoHJqhOVjjWBg+7f+xQQPtG1a+776HhRhhLUoItP5dN9sZzPX5
	q71+y121zq+UYq0/XzTm9vFEY+V5oTcNGnmf29qmi0kndw8LZCDW8neRhUMHywAwuLnbm+h6tIt
	BRPjoccs0AcjQTxzBcGOoJQXGuCcc1VFwICStthBOgG9aNicrWSEVIQoW6/s8hUh6/bf3tcLxLM
	UssZMKdjVNMTNsayz5VqyHkpwtG4mKRxHrB442e1B6+rUVECq3jPTsesxvocWzS54pLZqZXFjb2
	WTZZgXS/o6tETJQYfYDn2AM0guzAS5BTR8jPwZMbjL1+TQMD8sdhpbsF38WTHc5k1kCT6J6FGlm
	sjwg7VOQlRndqYyopvjg/LN1+PY3E40zeO9yhQlu13+RCEH56i/b1ROIME3pBnl7ajU6sMI7LsT
	Nu8nvCk+eUqQNaEcXNktsWnQIRHXbe+vJVmBK/fn4GeFd9Rn1fcUG1KXYhIGoNtTifO6EOj0036
	BD1coIoxVE6tDD4HieByAk6qKHPABR1VwluhuCpAMWdI1J16ioXwTsxoy7ahGQOET76sPVi+ur5
	j84ie8ATvlu3ESzj6zuyM/j2k8L6pFO2tw0sB00lYuapuBrhyriA/TlP1yRBvy34pen0as0jocr
	mSJbN0EYvNik=
X-Received: by 2002:a05:600c:4f8e:b0:49e:745d:c317 with SMTP id 5b1f17b1804b1-4a01b0087a5mr39314065e9.12.1790796080524;
        Wed, 30 Sep 2026 12:21:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2b3-0101-b51c-a607-3dcc-3979.310.pool.telefonica.de. [2a02:3100:b2b3:101:b51c:a607:3dcc:3979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9248ccsm3513165e9.3.2026.09.30.12.21.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 12:21:20 -0700 (PDT)
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
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net v2 0/2] netpoll: fix PREEMPT_RT deferred transmit locking
Date: Wed, 30 Sep 2026 21:21:01 +0200
Message-Id: <20260930192103.62973-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260928064239.32456-1-kmehltretter@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
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
  Three fixed RT boots passed; the non-RT control and treatment each
  passed three boots.
- An arm64 QEMU A/B test held the device transmit lock while queuing 64
  skbs through a synthetic CYW43455 SDIO device. It used HZ=250 and ran
  with PREEMPT_RT enabled and disabled. After releasing the lock, the
  HZ / 10 version completed in 128-178 ms on RT and 108-109 ms on
  non-RT. The one-jiffy version completed in 59-114 ms on RT and
  28-55 ms on non-RT. All 64 skbs completed in every run.
- The exact v2 series and pending brcmfmac fix passed 10/10 counted
  physical boots across a Pi 400 and Pi 500+: three RT and two non-RT
  boots per board. Every lock-contention run freed all 64 skbs without a
  timeout. Each board and kernel flavor completed a 1,800-second stream,
  ten TXHI stop/drain/wake cycles and a Wi-Fi reconnect. No counted boot
  reported an atomic-sleep warning, new lockdep splat, stall or lockup.

The A/B test applied the same pending brcmfmac netpoll fix to both
variants. The driver recorded zero or one dropped packet per run, and
host capture lost the same number; both netpoll variants showed this.

v1: https://lore.kernel.org/r/20260928064239.32456-1-kmehltretter@gmail.com/

Changes in v2:

- Retry device transmit lock contention on the next tick instead of
  after HZ / 10. Keep HZ / 10 for a stopped transmit queue or a driver
  which returns busy.
- Add the arm64 QEMU A/B results and combined Pi 400/Pi 500+ RT and
  non-RT hardware results.

Karl Mehltretter (2):
  netpoll: use a raw lock for the deferred transmit queue
  netpoll: avoid blocking on the transmit lock in queue_process

 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 83 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 7 deletions(-)

Range-diff against v1:

1:  b95097f73f29 = 1:  b95097f73f29 netpoll: use a raw lock for the deferred transmit queue
2:  bb9c0adcd8a9 ! 2:  30f5c80cea9c netpoll: avoid blocking on the transmit lock in queue_process
    @@ Commit message
           process_one_work
     
         Use HARD_TX_TRYLOCK() instead. If another CPU owns the lock, put the skb
    -    back at the head of the deferred queue, restore interrupts and retry
    -    after the existing HZ / 10 delay.
    +    back at the head of the deferred queue, restore interrupts and retry on
    +    the next tick. Keep the longer HZ / 10 backoff for a stopped transmit
    +    queue or a driver which returns busy.
     
         Fixes: 3640543df26f ("[PATCH] netpoll: fix netpoll lockup")
         Cc: stable@vger.kernel.org # 6.12+
    @@ net/core/netpoll.c: static void queue_process(struct work_struct *work)
     +			netpoll_txq_queue_head(npinfo, skb);
     +			local_irq_restore(flags);
     +
    -+			schedule_delayed_work(&npinfo->tx_work, HZ / 10);
    ++			schedule_delayed_work(&npinfo->tx_work, 1);
     +			return;
     +		}
      		if (netif_xmit_frozen_or_stopped(txq) ||

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.53.0
