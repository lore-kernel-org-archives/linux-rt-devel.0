Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866732;
	b=zJUeJxdcLxPSnuXnPgZ8zOh/DtjuQ++tZ0LaIG5Q9OGjNv2pM9yyViMRa+MgHRj1VFA1
	 S0gIv9Zg2WMSR3Rzb39uEcKydQn/WGQWyKwQh7bGNaC+nAYOoqe+6U8BYiGF9FpNq97iz
	 ssY8QjqXVgVP1g4jy3O71+LzCfR2XWHZZg4MfqNGZXo5+QUz+LwLfbr+Q1Qm1ld5Dq7IG
	 HdxtJW59A5SjtIRJmLPvjc0CzRppd7kqRtkJFgvMZ52RvFYZ38+qGQcwxVDY2/4dvzuIQ
	 BbaSU+yTFlTSMhTXcAnaFlwq+unBD/ExrtDIx5SquBBk0da56RqN1HUlNN6LZo/Emxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866732;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=YnYl0grphqtCTW16mbqB5OZ7Ar0uK9ejWodFsFluXmA=;
	b=r5fuK+c9370tJBRAoIRH3pTiRbQKWhu6niTqn72CMy/NEAIWBJaAthU2XxWp1otO7z0I
	 yLN1hxHL9RI60j4STlanpVRcMoZcqULryqzTxPPakKoB1O4zedX1ovOcq7TwtG0Bvb6ac
	 GZRjxT6ueFtm2CHdzaJxptKphfC8xoYrhKY4jPl9ViwshM+TQUA/owNautpXDGs4bbvpT
	 4lsw3UJXM/zVq2U/O0lN+4hCab0qj/QG53wuJsG0YY0pICOrpu1T2NPIoVSh9pdp5sNPu
	 zvDM9WSZWMfHNiDrqoL5Gbyo6hcug7x5MVRef2naky55C4YM4F3o2mUK06E4nfcmoPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D4606A334
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 08:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6D4606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793866730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnYl0grphqtCTW16mbqB5OZ7Ar0uK9ejWodFsFluXmA=;
	b=cOs2Z/H3fyglf48BU0THLdP2KnSdCqAFRgw/QMUR2e/5k5FXZ2YJAKG3F6lRcVbviNFW/O
	CSTFlBRkODuDbbwX2wfgUk4CzBC5OZ08fxypB8FCgI+09azSiPKx0vUw1oyDpxDVIOLD07
	iFt31ptmICj9BCexWB1sMOl6PXvn9ag=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-6eBXp8v-M0uS6rdM7kfZnQ-1; Thu, 05 Nov 2026 03:18:49 -0500
X-MC-Unique: 6eBXp8v-M0uS6rdM7kfZnQ-1
X-Mimecast-MFC-AGG-ID: 6eBXp8v-M0uS6rdM7kfZnQ_1793866728
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a21396efa4so2262525e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 00:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866728; x=1794471528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YnYl0grphqtCTW16mbqB5OZ7Ar0uK9ejWodFsFluXmA=;
        b=jOhelkf5bAuOfKEgdCliLjU+XyV0N9OpiZi/AbsvpaIuVdDPI2K2kfFRaaxTNRfuus
         OzuMy0RNX58GabTnSoNKDoPr6bY8b7SszGUvG/RbCB5llSUrmyGO12Jt4e15ZLxdKR2I
         AaBLwzmJutKn4kifNXrpp0Dqd2qIQakAvehduk81c8fYy6ujf/ETSl3ylUZzptH4lud0
         APqAmLHKDVffuzZjrTASKVaCz3Zl3WAanmunZkO43nVNBlQSsq+uKWL09y6qm1r1uKpK
         wtWF8tZwWat4/C58q+TpWJm8ixYfw9V5O/D7ONZVvWwybclJmjtPVGs/CnQUxZxj8s+a
         sz1g==
X-Forwarded-Encrypted: i=1; AKwUvBx6j9EUlfrRLrsAIVWILa3cRorFrS34/5aPT5gTo3GsiCM4v4NGCMdBCPGNnY2/o/y1QX7cFD0L8YF82W3iPA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8+XJb32OnonDgaklj7uROsKjq+Vbm5gTnDRTmXZhs2V168rc0/
	+IUct7jBmHdFafuKlSWSnyskAT2Nz9XspaYtoTen2d9dHR5xBYSyPDUvxChFCapQSsDySsU8xT1
	r+mYJu5fbpH61rDiRn16y5tD7T8m6DmaZJfNbYaWSW667k3GU+/O96I+l1QuHcArDeBs0
X-Gm-Gg: AYBFou24e3JeQmheZOesFeC05CB6pZ5shC7bEasZ7Pr5gOYgMcJd2fWat13lsXJi/OV
	tswfvpx4xnTS37R/3CLFWUnbiFA5FvEZwpbudfj0jzsziKjBC1dUhdj3JhXRY8khl34x/jmo1ts
	62Whr6A/jBCT7OMBp/UIwqegYOQbjfOFd5FQYD7q61CUehJRqVBA/UJ4EleNQw6RmyrZwnujQ2/
	9kc2Nx56UaJB7j9PbAtMna4+91Nj8TO++wRjzxWJTb2QYV0qhjoz+asVKy1mQ6ktdKP7qWOWAoA
	Dq7l1FGo7d13LOXo9MskZRSccpV1o10CybQprV8/eM2IEeTN6cBH34CR0gv78G1dMiHRvKMqze9
	w2sGS6lX9hyrNSjzf6+EK8raQ7Ym7SjMK0VUNO0+GTrx7ZSPxkHuumtZ9RwL7ipiHv4fFYk6vLR
	hIzPWANIbTbYlwyQ==
X-Received: by 2002:a05:6000:2587:b0:48e:5ad1:5e77 with SMTP id ffacd0b85a97d-48e6e261607mr37451525f8f.0.1793866727947;
        Thu, 05 Nov 2026 00:18:47 -0800 (PST)
X-Received: by 2002:a05:6000:2587:b0:48e:5ad1:5e77 with SMTP id ffacd0b85a97d-48e6e261607mr37451467f8f.0.1793866727444;
        Thu, 05 Nov 2026 00:18:47 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda203b6sm8437363f8f.48.2026.11.05.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:18:46 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 05 Nov 2026 09:18:34 +0100
Subject: [PATCH v3 3/3] clocksource/drivers/nxp-stm: Arm the compare
 channel from the state callbacks
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261105-nxp-stm-fixes-v3-3-8129b912e74b@redhat.com>
References: <20261105-nxp-stm-fixes-v3-0-8129b912e74b@redhat.com>
In-Reply-To: <20261105-nxp-stm-fixes-v3-0-8129b912e74b@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793866718; l=4847;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=gKd+ISmeFZF91zn4FW3sChMabdau9YNhi9yQ9k+mIyE=;
 b=vyi+xrok9WUJjuZ1aq0y/R2QRzxzfZKBFUfjS/ufrPzTsHkchLnh3UsYDssaTGvwk2ad1KIFl
 fqgaUxkZlyaBuKQMQv+qtIzSGIyZOpwerNeuoyWlgaPGdY7D7wfZzk0
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GK2U04je9cmdpzDmIIpmNXTeC1eh-6SxOPhcrjeWpSU_1793866728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

set_next_event() disables the compare channel, programs the comparator
and enables the channel again after the overshoot check. The trailing
channel-enable write is a posted write landing after the check: if the
counter passes the programmed value before the enable takes effect, the
match is missed. No min_delta can close that window.

Keep the channel armed for the whole ONESHOT operation instead, and
manage it from the state callbacks, like the HPET driver does:

  - set_state_oneshot() and set_state_periodic() enable the channel;
    a stale pending interrupt flag is cleared before enabling.
    set_state_oneshot_stopped() and set_state_shutdown() disable it.

  - set_next_event() now only writes the comparator, covered by the
    overshoot check.

  - The interrupt handler reprograms the comparator only in periodic
    mode; in ONESHOT mode the stale value stays armed until the core
    programs a new event or stops the channel.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 52 +++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index 81527745b7e2..8ad99863bdff 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -254,14 +254,27 @@ static int nxp_stm_clockevent_shutdown(struct clock_event_device *ced)
 	return 0;
 }
 
+static int nxp_stm_clockevent_set_oneshot(struct clock_event_device *ced)
+{
+	struct stm_timer *stm_timer = ced_to_stm(ced);
+
+	/*
+	 * Clear a stale interrupt flag so that enabling the channel
+	 * cannot fire an event from a previous match.
+	 */
+	writel(STM_CIR_CIF, STM_CIR0(stm_timer->base));
+
+	nxp_stm_clockevent_enable(stm_timer);
+
+	return 0;
+}
+
 static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_event_device *ced)
 {
 	struct stm_timer *stm_timer = ced_to_stm(ced);
 	u32 val;
 	s32 res;
 
-	nxp_stm_clockevent_disable(stm_timer);
-
 	stm_timer->delta = delta;
 
 	val = nxp_stm_clockevent_read_counter(stm_timer) + delta;
@@ -288,18 +301,16 @@ static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_e
 	 */
 	res = (s32)(val - nxp_stm_clockevent_read_counter(stm_timer));
 
-	if (res < STM_MIN_CYCLES)
-		return -ETIME;
-
-	nxp_stm_clockevent_enable(stm_timer);
-
-	return 0;
+	return res < STM_MIN_CYCLES ? -ETIME : 0;
 }
 
 static int nxp_stm_clockevent_set_periodic(struct clock_event_device *ced)
 {
 	struct stm_timer *stm_timer = ced_to_stm(ced);
 
+	writel(STM_CIR_CIF, STM_CIR0(stm_timer->base));
+	nxp_stm_clockevent_enable(stm_timer);
+
 	return nxp_stm_clockevent_set_next_event(stm_timer->rate, ced);
 }
 
@@ -327,6 +338,8 @@ static int nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer
 	stm_timer->ced.name = name;
 	stm_timer->ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	stm_timer->ced.set_state_shutdown = nxp_stm_clockevent_shutdown;
+	stm_timer->ced.set_state_oneshot = nxp_stm_clockevent_set_oneshot;
+	stm_timer->ced.set_state_oneshot_stopped = nxp_stm_clockevent_shutdown;
 	stm_timer->ced.set_state_periodic = nxp_stm_clockevent_set_periodic;
 	stm_timer->ced.set_next_event = nxp_stm_clockevent_set_next_event;
 	stm_timer->ced.suspend = nxp_stm_clockevent_suspend;
@@ -384,19 +397,18 @@ static irqreturn_t nxp_stm_module_interrupt(int irq, void *dev_id)
 	writel(STM_CIR_CIF, STM_CIR0(stm_timer->base));
 
 	/*
-	 * Update STM_CMP value using the counter value
+	 * The STM hardware has no periodic mode: the comparator stays
+	 * armed after a match, so periodic mode is emulated by
+	 * reprogramming the comparator here. In ONESHOT mode the stale
+	 * comparator value stays armed instead; the clockevents core
+	 * either programs a new event or stops the channel long before
+	 * the counter can wrap around to the stale value (~32.2s at
+	 * 133 MHz).
 	 */
-	val = nxp_stm_clockevent_read_counter(stm_timer) + stm_timer->delta;
-
-	writel(val, STM_CMP0(stm_timer->base));
-
-	/*
-	 * stm hardware doesn't support oneshot, it will generate an
-	 * interrupt and start the counter again so software needs to
-	 * disable the timer to stop the counter loop in ONESHOT mode.
-	 */
-	if (likely(clockevent_state_oneshot(ced)))
-		nxp_stm_clockevent_disable(stm_timer);
+	if (clockevent_state_periodic(ced)) {
+		val = nxp_stm_clockevent_read_counter(stm_timer) + stm_timer->delta;
+		writel(val, STM_CMP0(stm_timer->base));
+	}
 
 	ced->event_handler(ced);
 

-- 
2.56.0

