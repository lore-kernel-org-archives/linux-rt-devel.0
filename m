Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215833515C5
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794470; cv=none; b=S7XwwvpPPmBWfU9r42J6a1WDSdmQ46qA0bOrX+FX9p+wZYd0tby59dxdSayEgFDuWfnBiZ0xo9iL3VmKiyz9zWEB43GJxNAGpiMaFHl8wkSWNt58FrSO/BKmjXK/9O0s9a9XkYchuh2f1muqqF0d3657Pii0qHTqz5K0AmFKUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794470; c=relaxed/simple;
	bh=UCFeSMOs+Qi6rlEif4wp5NL4CT/HAxxrve974CVtz4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNg8gDI5O99Dvf2+H1Zd1XIpDbJqTGAIgko22a2reIXhI/5eljExQcd+dfWSd3A8K5bi7RiMqnGNlt+WF8ENfHbIgDnsqrU1zD0incAiZxXWXajAX1I9QTgZjw4WZjnDswX7bm/2XIvhAZtu6McdfcC/G3Em1xun8MQX5ny7zhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9O+mWtQ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9O+mWtQ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so46506565e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790794466; x=1791399266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aIRe9J9nM9kojEK5e8In+q+vzA6ofCEVTiqwmV0m+zo=;
        b=Z9O+mWtQ1oR+okCkSdwtny5LTFAK+wvovv3dZLEePyb06YbvFIsoMpolAZd8b5ZFVf
         enMDrSWFUSzdtbY3D4vXI9U0z+3Ha3C25jcrkBY6RTvq96OsG96VcTcrgTQbQ3f8YNEP
         D5TexldBXeyfTm8tgT13yF1Pw4zXkvoEXodVfZkpvScAEjq+jvdc8cdUrZIiXbzUyWbD
         3lXN5YudfWZvVEgaAUA+guyPxy+WuOC82gkQof6w1zv8AfAYbeKrLMK/qqTS8O685VFF
         Zuirsz1rBGPN9KVlHP20iAcVIojbU4yKVBNHU3gRTInqwlcRvmmNuC0UAME+bx3nsIoy
         +twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790794466; x=1791399266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIRe9J9nM9kojEK5e8In+q+vzA6ofCEVTiqwmV0m+zo=;
        b=RNoR4mKSfBmgpAVHud5yDpJrrMB2jVWhF22fvR8rvyrCyt/IwZb3vNiZ86FG2HKxB3
         L9dJSQwpRsABfDvEAasgQHcfQk/+RmmmjnHcYJ2JWNk+rzLYlkLlquoC9fHkglU6vW2b
         VQFdijg/lxsBHWy+TUuBO/lUar29MbmE30mAvu8T8V1ERGOUagMttdDm1b/BuoF81/UX
         afbg2h6cXruOx0uhuQcNTM8OtBV3h8W7T2ziYFTyesIXJWEDma8iwGNuCOnZrM7h4J7R
         6R8bDypxkY6rVYJwMGKHn2wqBShlL+UG6Cio0U1HAALb8grH/Jq9KZOELrVLLFj1cPZU
         EFKw==
X-Forwarded-Encrypted: i=1; AKwUvBzPlgzgyDpXqelEKXjShKaFEZtEaLuSq8MqovHwZvscJACj8ZtsfN+hM3Fe+e5Uki+dnsjoiMTtDYfLBdMXyQ==@lists.linux.dev
X-Gm-Message-State: AFuF++leY32wqxFM7MKDUwxIbSFnX2baDINZZ1c8DoQzjqCdJZeYf+fd
	IjzZeqPPH9VwJEtaFl5oAQMsYa5huD1JutUzta5NrHBeZuyr6idHPsw5
X-Gm-Gg: AYBFou39F1hPGr3wlznf5KjH1gzzgGNlfvHNvWgI9zPbilnnn83U0az41uTQu5NBfpX
	/caGJ45q+O4zp7as/ymzuR1/I2DIt5zJK9n/jtsF5V0Yc/BhFh0VG3a66k786CYqJibTRT/Xull
	EWl2CDnHkZJRAL0692DtJeBtaSaVUuRPMlIi845M54JV9t31GdXETNuoyzhJ8pUGapF6+ylbaAh
	7qmpHkKZGhwNYC1sqZ1QltCvf566JqNl6xjtHNj4XgqWnmuFt9Gb0foa2U3+kFMS0IERtCAOZRs
	dksQ5yvKGK9LNaBrQrp+tBGlwwmN+uAgLWLaxZSEDOOi7y44p7mXXjgWutqgmJKBeG0+w3A/cll
	B2WtNjuRNM5Sq8G/r+Rc/xg8ffozFQXVO+7lWEjUQc4B5qWVYIopvZ5uZxAQIcaMDiWOWU5lDn+
	xUTaJad+tr6COF7m1K212RF7rTQ6Z8u4YOhErtioAhMKIqBU/sB2X1Z2/+aCPEuYcbHwhg0kDgk
	Jh0y2HmHwJblBZkbF9RLTefSSiM45ZE3/8xzrMNjlRJHI65ZtW44dHEVRjWN2tyx79ZBPkFHhiD
	JjNbjwXXU3PgNlqjfyFMfFmPw7AryeI1CBEP0O6Cd6w9haRSxkXlF0hDYWrpKtCg6dQ4etFX1nG
	D
X-Received: by 2002:a05:600c:3b99:b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-4a01aff6a1bmr50678345e9.23.1790794466174;
        Wed, 30 Sep 2026 11:54:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2b3-0101-b51c-a607-3dcc-3979.310.pool.telefonica.de. [2a02:3100:b2b3:101:b51c:a607:3dcc:3979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01fa137basm1542095e9.1.2026.09.30.11.54.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 11:54:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll context
Date: Wed, 30 Sep 2026 20:54:17 +0200
Message-Id: <20260930185417.61865-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the default fcmode=0, netpoll calls ndo_start_xmit() with hard
interrupts disabled and reaches brcmf_sdio_bus_txdata() directly. The
function takes txq_lock with spin_lock_bh(), and the queue helper takes
the embedded sk_buff_head lock. These locks may sleep on PREEMPT_RT.
On non-RT, spin_unlock_bh() can run pending networking softirqs before
netpoll releases the transmit lock, causing a recursive transmit
deadlock.

Use spin_trylock() for IRQ-disabled calls and enqueue with the unlocked
skb helper while holding txq_lock. On PREEMPT_RT, reject hard IRQ and NMI
callers, where rt-spinlocks cannot be acquired. If the lock is busy or
the queue is full, return through the existing drop path. Do not evict an
older packet from this context. Suppress the queue-full printk because
netconsole can recursively enter this path.

The flow-control callback takes another spinlock, so defer it when an
IRQ-disabled enqueue reaches TXHI. The data worker rechecks the bus state
and queue length under txq_lock before stopping the queue. Existing TXLOW
handling wakes the queue after it drains.

This fixes the direct SDIO transmit path used by fcmode=0. Modes 1 and 2
take the FWS lock first and need a separate change.

Fixes: ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Testing:

- This revision passed W=1 sdio.o builds on x86_64 PREEMPT_RT and
  x86_64 PREEMPT kernels.
- This exact revision, together with the netpoll v2 fixes, passed 10/10
  counted physical boots across a Pi 400 and Pi 500+: three RT and two
  non-RT boots per board. The softirq trigger delivered 64/64 records on
  every boot with no driver drop. Every lock-contention run freed all 64
  skbs without timeout, and every TXHI queue stop subsequently woke.
- Each board and kernel flavor completed a 1,800-second numbered stream,
  ten repeated TXHI cycles and a Wi-Fi reconnect. No counted boot
  reported an atomic-sleep warning, new lockdep splat, stall or lockup.
- The exact revision passed combined RT and non-RT QEMU softirq,
  lock-contention and TXHI stop/drain/wake tests.
- An unpatched PREEMPT_RT Pi 400 reproduced the atomic-sleep report. An
  unpatched non-RT Pi 400 deadlocked and produced 32 RCU stall reports.
- An unpatched PREEMPT_RT Pi 500+ reproduced 21 atomic-sleep reports.
- All brcmfmac tests used the default fcmode=0.

 .../broadcom/brcm80211/brcmfmac/sdio.c        | 91 +++++++++++++++++--
 1 file changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 381801af3a..170450306d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -516,6 +516,7 @@ struct brcmf_sdio {
 	bool dpc_running;
 
 	bool txoff;		/* Transmit flow-controlled */
+	bool txoff_pending;	/* Deferred transmit flow control */
 	struct brcmf_sdio_count sdcnt;
 	bool sr_enabled; /* SaveRestore enabled */
 	bool sleeping;
@@ -2796,8 +2797,53 @@ static bool brcmf_sdio_prec_enq(struct pktq *q, struct sk_buff *pkt, int prec)
 	return p != NULL;
 }
 
+/*
+ * The caller holds txq_lock with hard IRQs disabled. Avoid the skb queue
+ * lock, which may sleep on PREEMPT_RT.
+ */
+static bool brcmf_sdio_prec_enq_irqoff(struct pktq *q, struct sk_buff *pkt,
+				       int prec)
+{
+	struct sk_buff_head *list = &q->q[prec].skblist;
+
+	if (pktq_pfull(q, prec) || pktq_full(q))
+		return false;
+
+	__skb_queue_tail(list, pkt);
+	q->len++;
+	if (q->hi_prec < prec)
+		q->hi_prec = prec;
+
+	return true;
+}
+
+static bool brcmf_sdio_txq_lock(struct brcmf_sdio *bus, bool irq_off)
+		__cond_acquires(true, &bus->txq_lock)
+{
+	if (irq_off) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		    (in_hardirq() || in_nmi()))
+			return false;
+		return spin_trylock(&bus->txq_lock);
+	}
+
+	spin_lock_bh(&bus->txq_lock);
+	return true;
+}
+
+static void brcmf_sdio_txq_unlock(struct brcmf_sdio *bus, bool irq_off)
+		__releases(&bus->txq_lock)
+{
+	if (irq_off)
+		spin_unlock(&bus->txq_lock);
+	else
+		spin_unlock_bh(&bus->txq_lock);
+}
+
 static int brcmf_sdio_bus_txdata(struct device *dev, struct sk_buff *pkt)
 {
+	bool irq_off = irqs_disabled();
+	bool enqueued;
 	int ret = -EBADE;
 	uint prec;
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
@@ -2826,22 +2872,39 @@ static int brcmf_sdio_bus_txdata(struct device *dev, struct sk_buff *pkt)
 	bus->sdcnt.fcqueued++;
 
 	/* Priority based enq */
-	spin_lock_bh(&bus->txq_lock);
+	if (!brcmf_sdio_txq_lock(bus, irq_off)) {
+		skb_pull(pkt, bus->tx_hdrlen);
+		return -EBUSY;
+	}
+
 	/* reset bus_flags in packet cb */
 	*(u16 *)(pkt->cb) = 0;
-	if (!brcmf_sdio_prec_enq(&bus->txq, pkt, prec)) {
+	if (irq_off)
+		enqueued = brcmf_sdio_prec_enq_irqoff(&bus->txq, pkt, prec);
+	else
+		enqueued = brcmf_sdio_prec_enq(&bus->txq, pkt, prec);
+
+	if (!enqueued) {
 		skb_pull(pkt, bus->tx_hdrlen);
-		brcmf_err("out of bus->txq !!!\n");
+		/* Avoid netconsole recursion. */
+		if (!irq_off)
+			brcmf_err("out of bus->txq !!!\n");
 		ret = -ENOSR;
 	} else {
 		ret = 0;
 	}
 
 	if (pktq_len(&bus->txq) >= TXHI) {
-		bus->txoff = true;
-		brcmf_proto_bcdc_txflowblock(dev, true);
+		if (irq_off) {
+			WRITE_ONCE(bus->txoff_pending, true);
+		} else {
+			WRITE_ONCE(bus->txoff_pending, false);
+			bus->txoff = true;
+			brcmf_proto_bcdc_txflowblock(dev, true);
+		}
 	}
-	spin_unlock_bh(&bus->txq_lock);
+
+	brcmf_sdio_txq_unlock(bus, irq_off);
 
 #ifdef DEBUG
 	if (pktq_plen(&bus->txq, prec) > qcount[prec])
@@ -3754,6 +3817,21 @@ static void brcmf_sdio_bus_watchdog(struct brcmf_sdio *bus)
 	}
 }
 
+static void brcmf_sdio_deferred_txflowblock(struct brcmf_sdio *bus)
+{
+	if (!READ_ONCE(bus->txoff_pending))
+		return;
+
+	spin_lock_bh(&bus->txq_lock);
+	WRITE_ONCE(bus->txoff_pending, false);
+	if (bus->sdiodev->state == BRCMF_SDIOD_DATA && !bus->txoff &&
+	    pktq_len(&bus->txq) >= TXHI) {
+		bus->txoff = true;
+		brcmf_proto_bcdc_txflowblock(bus->sdiodev->dev, true);
+	}
+	spin_unlock_bh(&bus->txq_lock);
+}
+
 static void brcmf_sdio_dataworker(struct work_struct *work)
 {
 	struct brcmf_sdio *bus = container_of(work, struct brcmf_sdio,
@@ -3763,6 +3841,7 @@ static void brcmf_sdio_dataworker(struct work_struct *work)
 	wmb();
 	while (READ_ONCE(bus->dpc_triggered)) {
 		bus->dpc_triggered = false;
+		brcmf_sdio_deferred_txflowblock(bus);
 		brcmf_sdio_dpc(bus);
 		bus->idlecount = 0;
 	}

base-commit: 6f63e919fe1e335b8abcb3a28bfd4804a98d875a
-- 
2.53.0
