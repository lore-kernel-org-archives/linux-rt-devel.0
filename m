Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793004296;
	b=ZZephwCvbb5OW5aHres5wDYix5c+RgZPPhsBlHvMnUjiH5Rv8iUnH8pWfCdnZ1Twowv4
	 mi41s066ystocfnsna1WCGVJ0BUAn1Ai1sDxB3wYRHohpyBOYtx93NyeRdN7aJljpj52w
	 h9EYs0csniiEpyoKL1jz6h24lpn1kOdqLq21g1KanJf8YHT3lVFCDshsdBhefn4PjEH6A
	 TZln1H8/LxpG05TZgMr4j2VmVK9QRyIPPjj/sJYyAE7PldUMcPo/fKBwBWRa7r7AUEUky
	 U+1aPSStbIl2gH29nyCf7J86z6wp5WO6887/uTjzLL4fxtIepHrUfuNN6HqYMO7eVUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004296;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xEGFMoBSqlCkE1A3S7YRAvd7sH19TwEaNbWjjfQgI9I=;
	b=DBQ5nB60SMfPMy4bCz4SbIJ2b6wY79faAV1jfaNUFrWXVnya8Rnr08FvLkpBrRAC+YfT
	 k54/IMaRe2mkoKwiBUbOSSrfyjWHIq/Nup2yMMe+xnq5s53QdRyy0hjXfZdm50zWLyZSz
	 d8t/RL3XOpTkbhuag793rHdR29qz2FpdDhCBvBfMQAcvdyk+Ydfuo8cUSRQIZXrWquH2Y
	 nQLd+Z0R1gqfK8g5QbZabQStRLFxXF/sT1h7701kMh2BqvuVuMz0vsUVJ8D9g5CQOB8pv
	 5u7PEVVQVfyzDTWJq7KpWBlNbdl+fw1pxugCMI0y+0t4zvPH0WoXZJLR1NnynrNbslQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQ8kgciu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8358606A31E;
	Mon, 26 Oct 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQ8kgciu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793004295;
	b=0SyfhU9oz03BL0ldli+0fcDQunM5HVWF9ZdL4W9c/aTipC4HyrY+KUV+1WdIu1X4XwnP
	 5Vt90wCH9yF+KQ51xCAt30np9I/jshcMRbivVuZPhjG34HQEcoXrDbHM+HGqx1NxZy5sF
	 Z22OYzJZdijDzbt4w6OZ23rRv7v79l2rk9CkyyfD80AIjJ39b0FRSXlqkbSSIOaIdSsw9
	 Wm/pfIe+biNU9/D4mcofiL6mVLjV1+5O5mifzhKYXl9/yEe2Hwqu3qlF+V4u115QWNF4/
	 G9jG0/bLXLlFu1EjramlAXdksR3LuHdoLw6L8hi1dmoee0SzSyCI3xKCKKjyeJtv3rw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004295;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xEGFMoBSqlCkE1A3S7YRAvd7sH19TwEaNbWjjfQgI9I=;
	b=r5p73S8WQhI00Ia60CmB4hKoNQcUI8RaaBRcIzTqmzFKZcbzBSBTR7fmKTVobVOw1so+
	 nry/XdFLLdX+z8M7vmfdMMOfyOC+u6VsPzdCPVWZ2kwKXwB7H0AsXAqLF7sseVuY/N/BY
	 Gn+XrtswMYBOW48FHSs0XGuSonfyiwYxOjYj2/Tx+Ifh3BhcICvI3/BXrb+6/wA2YUMua
	 Yr8igp2JYoBT9HTfqp8b2JGVeULJM1prYOLjw4GrJqYD/dPXK9O2vIfKpN8sxOcekv2mC
	 A6q0YEsEvfRS0tYNaXDYKRC7n9NXaUT6v6/dWTYpDFAHhc8UuC2FWd6P+kLjOTQE5pQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6D69D1F01828;
	Mon, 26 Oct 2026 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004295;
	bh=xEGFMoBSqlCkE1A3S7YRAvd7sH19TwEaNbWjjfQgI9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mQ8kgciuLtx28dkxCOTRzbeMcOaH+IQPUg10oV7RhkISkE9sloLazxOHhRgnjm4/C
	 Sc4zIac4G4HR2gNTeXhvvLy3Du8O8PQ24OpJSuIBE44T7Lw5oZLBELm539UxcW8KB7
	 SNCy4CCajdzPo8THscby490MJz3yG5SUyAKajNeLhSQLNY/X1o2a3+olODgDvyylwn
	 jv9LL5Y7MAvnUrtGd1rRAnZBoCRF5p71mDt2D3PM+pjLYvDNJpg9+qQAwZV7mMUj4Y
	 1ymIKeoXt2UYC2C8lg/KCmiE6ZUdAsiLLGHCGm4PiMdogmM43vw9zt10mOxiTDC1Si
	 Wm4Is3X6Vyadw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D69B844C73;
	Mon, 26 Oct 2026 08:44:53 +0000 (UTC)
From: Enric Balletbo i Serra via B4 Relay <devnull+eballetb.redhat.com@kernel.org>
Date: Mon, 26 Oct 2026 09:44:33 +0100
Subject: [PATCH 2/3] clocksource/drivers/nxp-stm: Fix missed comparator
 match in set_next_event
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
Message-Id: <20261026-nxp-stm-fixes-v1-2-20a64a4ea454@redhat.com>
References: <20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com>
In-Reply-To: <20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793004293; l=2807;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=L1v5tjj5j+Wq0siw9q/hKpdjRRXRlMLbbuhC7iKp4ic=;
 b=cGWaYFHHdQAsdou2DcXrTVsUM5zfG6BRmXstksyJxMgAfkKif+TedfSdBhJTJ4xbtCHlyzVNj
 9tqansaOe7dBKdq00wXcVflgmQKIeqRmfXu0rqghT4itUZO/ol+DvI8
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Endpoint-Received: by B4 Relay for eballetb@redhat.com/20261026 with
 auth_id=1324
X-Original-From: Enric Balletbo i Serra <eballetb@redhat.com>
Reply-To: eballetb@redhat.com
Content-Transfer-Encoding: 7bit

From: Enric Balletbo i Serra <eballetb@redhat.com>

The NXP STM generates an interrupt only on exact match between STM_CNT
and STM_CMP0. If the counter passes the comparator value before the
overshoot check runs, the match is missed and the hardware must count
through all 2^32 ticks (~32.2s at 133 MHz) before firing, causing soft
lockups.

The existing overshoot check:
    if (val > nxp_stm_clockevent_read_counter(stm_timer) + delta)
simplifies to checking if counter_before > counter_after, which only
detects a 32-bit counter wrap and misses the normal overshoot case where
the counter advances past val.

Use a signed comparison on the difference between the target and current
counter values instead, following the established pattern in
timer-imx-gpt. If the counter has reached or passed val, the signed
difference goes to zero or negative and we return -ETIME so the
clockevents layer retries immediately.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index ee249fed1b91..ed7662a4e2bc 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -247,7 +247,7 @@ static int nxp_stm_clockevent_shutdown(struct clock_event_device *ced)
 static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_event_device *ced)
 {
 	struct stm_timer *stm_timer = ced_to_stm(ced);
-	u32 val;
+	u32 val, now;
 
 	nxp_stm_clockevent_disable(stm_timer);
 
@@ -258,16 +258,12 @@ static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_e
 	writel(val, STM_CMP0(stm_timer->base));
 
 	/*
-	 * The counter is shared across the channels and can not be
-	 * stopped while we are setting the next event. If the delta
-	 * is very small it is possible the counter increases above
-	 * the computed 'val'. The min_delta value specified when
-	 * registering the clockevent will prevent that. The second
-	 * case is if the counter wraps while we compute the 'val' and
-	 * before writing the comparator register. We read the counter,
-	 * check if we are back in time and abort the timer with -ETIME.
+	 * If the counter reached or passed 'val' during or before the
+	 * write to the comparator, the hardware match will be missed,
+	 * resulting in a full 32-bit (32.2s) wraparound lockup.
 	 */
-	if (val > nxp_stm_clockevent_read_counter(stm_timer) + delta)
+	now = nxp_stm_clockevent_read_counter(stm_timer);
+	if ((int)(val - now) <= 0)
 		return -ETIME;
 
 	nxp_stm_clockevent_enable(stm_timer);

-- 
2.52.0


