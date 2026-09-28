Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1444CF44
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577786; cv=none; b=QncR034EtLKZWZ/V2tqj1erLiI2sbLjC6qjfR1IImjnoL5M8XD3NRtvvKM1VCZodFjQV9v24EVe/m2uU7t0v2LD2D6zaiUrQPFjIbi9cppwov22JG6DHFHdIni0njBAzKxJeJocoZZ2A9m4vPiZ11BklOuT0qSOv/s2HepFaSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577786; c=relaxed/simple;
	bh=y/c3vuZT9JK4EGUVD5FlxfoGZhyoXAmopRCdzFOZeII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ir00y/YZMwbNdtqGkha88MQz/khMoQaolADlMARp+6hAUEUk3jmBvu+eJHx1vfU6aQXqqE2Lur5c9zFHHYQvXsoh06uq9kncf4mQ/gCazyTV6UGvA2dH7SrDaDip6tQ+Opw0oMUlAoa+p+d6gj/AERwNLEY70WZpnE21YJZ5C+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4sLHZ5m; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4sLHZ5m"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so1485138f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 27 Sep 2026 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790577779; x=1791182579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EleACgwDvShW2Hh8e1MDeVc2Sd39pZcCSkJXUD9MqEw=;
        b=R4sLHZ5m2dNybdLstkKaGQikXOEfwwS1ussdVKt4Zh+gX8oWMDKtDZBcEOx4Rm8WER
         VTi2N15Ju84f5ChOtuRnJxuB2LxAiTEkGQz/11stlaiCtj0A8GMuabKU/MS4Hv35ypil
         XPuJWGnfg7rTfhY5Il78dFnQqXZGZZIot8G2P9IfdAB5YhannuJRdvnL+Cww753Ow3IO
         MDCuNf9j75txv7Jm9CNWG1jpnfOIGrAZ05CIlLuhOKTaUyjKN45vy6Vi7a2pZvR8vTcw
         /wYtMAZ6UIFqZRG3tq7xsYbU6JwBAXaTRIOUi9v/3diOsVyzz+XL+pxNT31nBldX16fi
         yqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577779; x=1791182579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EleACgwDvShW2Hh8e1MDeVc2Sd39pZcCSkJXUD9MqEw=;
        b=pz8Dx8+/2CN+YuIVBWKiH4WbCRXxmKnBFx5qvDJqDAyFJDoOIgHTAOTbm4QDmQuaek
         bGGo+y7uUBCmfna8ziauCHBGRedGYkx5+XY6dB9uD0UP1CtOOUFAm+fDVW0iOre2hWrL
         sTwYqJf9rVp/fwjNWRbcDFsxPU443HvTAXTBFTyvLQJCx0gVuwj7q0MCBC9FXroh9NLO
         uPVE1XR/K2YmGLNdVRLXhqELD6RugeFGxrJW4NIgsqv765CgF8WLsiba98uv6Z8rYYbl
         iLYwOa4/7qxVb7cYOb8X/r1OWroG5Elow1BM+dbo5IdFlU3ne7QAN6ZlNKnTCOzd9I7R
         snxg==
X-Forwarded-Encrypted: i=1; AKwUvByK64v/85L59zdOhXSz00O+8f2BMMqoixZh54PwmzzHIRbN8SX2hcoMoZelE95FMdG8mm/m6DZyh0kKODJ1tg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL/wKUKMUVYqolcSF0Aemis+/Fm2uc0dt4SiOxis475iGfHP4j1
	iPKu7nIIuRibHgkF+1pj9GXjU7KlZo0TLPYFEGVn16QrZhNfix7GBn6q
X-Gm-Gg: AYBFou3AAqR6QpPwkXxyegxS3RclUyYcY7PgfORbXYtFYW69bs8VAN6ausf51SA939O
	Rx1urbbq5jbAIAkw1pA+jSPxLan71X/5xz0fq4Kjam2j70nYzTNtmm9MAUU9gWnZjWJrQbLBqCk
	1ye+Wyz/5TA2OtuZoZYwDearFNGNzcO+FP1nRjPCPI6Cr7HNHYqbwiG24B8cWsNVoSIms7tcA+q
	05nwRMTTaxmr8fniPQfOusHEv/UGQOqfDe2KPtMcS5GuZeZ1ruTpEj5HbHHcjom26RE4tZyRorU
	N8xQS09rq7Ig9q5SUguU5IUEGDDJe2ol0MkaNI/xfptfPqLVGwc1Q4HVdQn32qDU93CY8sMKTCV
	6ccHutsowKk7Sg+7XoocE9qPLg2YfZsM3aemnck1ywbezLcelaNHWANlaCJyOrXbj2eSHEaKHGB
	YIE+VOHZxoJOwRIbmQFOGtrAsEDHsWWYUiWA/zy1NBce7IL33W/vn9DnD+1+qQ7T6rubhHXBbCj
	A9NzYr7Q5nCnDVEh1uYKyleQAHv2eVwqzxLiqrS20LTXlV+0RYXsKxE7AiUboAp/X7xHSBi0NwZ
	yD0ICllik9Ln2AW2h2rZUp1RgkMKYItY8Sp/U1msq+/dnOXpmjAS6eaYVxMrWM9/5Wrsd7UWouh
	ngFc9MA==
X-Received: by 2002:a5d:6f1d:0:b0:487:1102:d697 with SMTP id ffacd0b85a97d-4887d9f99d4mr17976537f8f.8.1790577779202;
        Sun, 27 Sep 2026 23:42:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm26283196f8f.4.2026.09.27.23.42.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 23:42:58 -0700 (PDT)
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
Subject: [PATCH net 2/2] netpoll: avoid blocking on the transmit lock in queue_process
Date: Mon, 28 Sep 2026 08:42:39 +0200
Message-Id: <20260928064239.32456-3-kmehltretter@gmail.com>
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

queue_process() disables interrupts before taking the device transmit
lock with HARD_TX_LOCK(). The lock may sleep on PREEMPT_RT:

  BUG: sleeping function called from invalid context
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0
  Workqueue: events queue_process
  rt_spin_lock
  queue_process
  process_one_work

Use HARD_TX_TRYLOCK() instead. If another CPU owns the lock, put the skb
back at the head of the deferred queue, restore interrupts and retry
after the existing HZ / 10 delay.

Fixes: 3640543df26f ("[PATCH] netpoll: fix netpoll lockup")
Cc: stable@vger.kernel.org # 6.12+
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/core/netpoll.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e0cfcb05468e2..a3c94f0b3f764 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -166,7 +166,13 @@ static void queue_process(struct work_struct *work)
 			skb_set_queue_mapping(skb, q_index);
 		}
 		txq = netdev_get_tx_queue(dev, q_index);
-		HARD_TX_LOCK(dev, txq, smp_processor_id());
+		if (!HARD_TX_TRYLOCK(dev, txq)) {
+			netpoll_txq_queue_head(npinfo, skb);
+			local_irq_restore(flags);
+
+			schedule_delayed_work(&npinfo->tx_work, HZ / 10);
+			return;
+		}
 		if (netif_xmit_frozen_or_stopped(txq) ||
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
 			netpoll_txq_queue_head(npinfo, skb);
-- 
2.53.0
