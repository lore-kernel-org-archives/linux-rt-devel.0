Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A973DDB19
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796091; cv=none; b=kFZSgxNNpJCm2wmy5Cf8ompKRpwoyzJglo/OiYFKCszJZkkEqxKQW6QheuQMtITVagqkBBs3fmaD+YlilK6ICiOCzBB6lKfP5tv0xRnGkm0zFFG7p0oNSXQ9+cWKjfsFaBbuxBNtOH8tL/c0Y35Qxrd+zoDQZBwdCo9h1OaiQ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796091; c=relaxed/simple;
	bh=uZKo3LvjIw/jQo2DcJhlrJtg2qwhUGJRKYHVpUos/Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXfjEiNUJOtOB/ftyUhS7EmZB5PZBM2fdwGQaWaTwH0wCGOYQX+Pf32JL4q1HeMnWysiAJku+65ZpFaLXGvYxU6RgpaVeNjhSbvY6OVul/A+QN7rhwu4pshgEr+72INeZeWJ60ycO+y1fhrm3pFywyuiDH9NVTBR0Sid3AwCsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTCkzk5D; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTCkzk5D"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso59357195e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796088; x=1791400888; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbYiN1Bd29zaEpgdDuLGxrhXKVFH4VSvfh3sFDNw4+w=;
        b=kTCkzk5DDmDKc0GFY/AosNZ5XBkImJ09l58oUXJK/iJjFSXCb2kOLD4L2ed3pFGsUS
         3bX9PcC+ngnZKB/B0OQajOa+Jwz4NCBGl+o0Fwqt6uhSdcvmEDDufW5FNIJ8B7KPQuaZ
         F8APy9tnWdFaDED1iVXr9Nk8RGssZ5AFRdMd/Q0uhIm31J6wC0TFbrbUX4zjk0TX4o6z
         hS+eRU8d/A/zRarH3XfFMyFdILXNThfk/vj/SgR4+4dDK9oEmpTVy/XCT2N0rIqDPzru
         VBgAu4dRaXRO35xhFBafcAZdUi9wApubOF46hpOUNLP05pXdZ/7MF2pUUSZXhepYzdTR
         +FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796088; x=1791400888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SbYiN1Bd29zaEpgdDuLGxrhXKVFH4VSvfh3sFDNw4+w=;
        b=VEzgrbbXNwn1IOH6w9Aqt7Aq/xhLxK8Yf9Br00DlRvKMYLSqseagY2cF8JLWndooit
         lLBo161wMnrVqzFI7+jDeWjSVa3C5Q0Qs9qUd0OoKZR6QPjc7HOUDkedPfZcRIZEMbQY
         QarPPH3RQB8rRhldGmgnVFLzfpX0oJnUap59YUVdIO7TF4SDJcBV/CPmZ252MJvat8yS
         X95MKzJhgKuROCmCxmAmD2BwDBzuFvCH6eK+bBP/rX1H5d4b+bOJKfl8A2kM1rvqW3bU
         GUp+WZzSDbdnLl0Zsaghx9HODZACCB91FKbMklYjT01GCdl7+EcK82ZE4FY6V+Ywss4p
         awMA==
X-Forwarded-Encrypted: i=1; AKwUvBxPblXc2McNq0nEjHWwLp+n3s3t+6RMSV5KG01eX6iNZ+C3AQl74O+xYjX98peF8DZuB3TTzHKHaJuvdu/zbQ==@lists.linux.dev
X-Gm-Message-State: AFuF++moMq80avVTQ75TXH+Jm9+OlQf5k+8+RPHaHqdZU5r9cyMLYiD/
	usUTPfSWF7c6x40eB/DRFQuiAzxTwhvncXhxrRp2ooNFGsbk7pUg4Yql
X-Gm-Gg: AYBFou1mEouhLiC13AlBDwIkckS3YI6dwBdShWUtWKEdX8I1ZLQB2MkHy67hkr/CNWt
	FCjkqFxc1dFRa9CgHoyEb+tlQeW7aykrXI3bWamw254F9WZRr8v8tah/utMfS5sEbCCRzsupN20
	3+A1PIGTjTeJr026NQYC6m9RgZ6x+BH9TEg4qkD/H2h4FSY7LWggUltFmi4EcZ0eO5ZJwdF8iVr
	2tNjfqGURSTei2PxOueSq+NTFJHfyWf3qxCw1FYnkBntww8ohwoQTU+u9ch7wg+oM1VVKhZfGcI
	8gl5mQL65JbbxTRGl+79wWHskJtHepgq1UONlJ8vcFx87xy+yTAui1YxX3+G5yHz9ZlC4KhJXyR
	+hmPWcOLL56edNv14swI0gq58ZL4W0bkv3tt0W3xwvqrKGzwpiqhaMzPskynH81cZsQyev5JYQV
	mvWWYVfpM80Pf1N3NJn54fy7kfttsQ8hrEY3nVGiXdEeQg+syOfQABZQtc86quWHunNVq66AIPr
	ki98A1vry5p+lkTxqLWT8+w87umneHygzUudufJKpn+HEANkhExomj2gOjcykvsM1BS70ytPgs2
	eWW8bm0phVcn3TNh17tPgmM4NXTooYh46TbeXBqQgetM4gVD+JcHxq8sM8UUbWG0FhzxxuxVnvz
	U
X-Received: by 2002:a05:600c:4687:b0:4a0:3a3:33e2 with SMTP id 5b1f17b1804b1-4a01adde08dmr42117895e9.5.1790796087622;
        Wed, 30 Sep 2026 12:21:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2b3-0101-b51c-a607-3dcc-3979.310.pool.telefonica.de. [2a02:3100:b2b3:101:b51c:a607:3dcc:3979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9248ccsm3513165e9.3.2026.09.30.12.21.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 12:21:26 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] netpoll: avoid blocking on the transmit lock in queue_process
Date: Wed, 30 Sep 2026 21:21:03 +0200
Message-Id: <20260930192103.62973-3-kmehltretter@gmail.com>
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
back at the head of the deferred queue, restore interrupts and retry on
the next tick. Keep the longer HZ / 10 backoff for a stopped transmit
queue or a driver which returns busy.

Fixes: 3640543df26f ("[PATCH] netpoll: fix netpoll lockup")
Cc: stable@vger.kernel.org # 6.12+
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/core/netpoll.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e0cfcb05468e2..8d8e3c33cfdfe 100644
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
+			schedule_delayed_work(&npinfo->tx_work, 1);
+			return;
+		}
 		if (netif_xmit_frozen_or_stopped(txq) ||
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
 			netpoll_txq_queue_head(npinfo, skb);
-- 
2.53.0
