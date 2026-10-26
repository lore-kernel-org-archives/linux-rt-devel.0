Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793004295;
	b=QCpRsLEvw+4Gns+yWKQp0px+aBo0OJRoJG39xsin2IRmFNWMt9A3LB9VIhEu7G6ZwcDU
	 985GNlabITMmA8+NKJKPjSeg40Smnbgj2S6pk5SBjuBVsiWaI6pob5ZE5/TTunTmecLGh
	 v/LgFQ3B0D9DoHDnxmoKnxWUBPgkG6GwhqMp1Bv57Yvsfm1TQk3oj12lrjQPe+3HOwAcS
	 h63GPTaBa4bTOvntKNUFYKs6QBgw5HzV07R8MUzFLCPob1QEoUZ1n0PXXGx+CkOLoqBAJ
	 de0NXJniQbLTIvHkYfIDEp3+Y7MWq94/G5KHsEjFX3vTSCkmll04Oo53sQ05hyfSEHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004295;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CwmLXq/62/1T0UmWDZrUZhiTccO4dV8Xr/kNTOz6adY=;
	b=hubKXdBTKpSV6rrs83alnuByei3fq4K1gLo5P+RK9IM89TikqqnWUavC7jjhUvgbZb5/
	 OqanCJzmhMBDHRCvveSqApmpqsGLkk84zpClQyL16HpRXE2AyBe/hjlZtBES6a9DDEOny
	 oE6Fs3eKNgf/2NvXeWxPLDncDXzREacICwENWSA0eCxmJ8lieytJoZfpMwYRasaX2237Z
	 dxlqHgtlwavTLE3kpmHqQgNoEoGD5kIeLrX5oNxGFngF4V59z/wp5+z0LUSE8I2v3zGKu
	 iBS2ExdWM2E2M9C/EqV+N2gJF1rBBLscYvRkC8DIm7BcMOZGiOSnwELd1/ZyaJewbGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xc5q6CC1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E5606A31B;
	Mon, 26 Oct 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xc5q6CC1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793004295;
	b=UCt+sVlOfGqPAFO3JcduXWgJPqXcOUFTtk5MXaHywzPTX6tLli6/xydbdz5UezNGpqm/
	 HFOkWJvXPVtGXYv+XF7m+xOjP8DGVk6mAQx3Qtj59oC33ReCdO06GzafmOgwQ7iaIdlGO
	 T65xy6aavzLIXClTSGKZzq93YgEl+IPnH6SX1Licvn+w4UB52iDFnrwbUCS6k5tsrGJR2
	 JbCHHF2RZ2Y6tKm5CXfQZpqjT4ssBXZpeNyi9NINpaSKULvKd2HGfRxtcGO+EXkro2EuO
	 Gfikf+biH/vzuy8sqvSmjZMIulwuYXSZwg5Zn+8Yd5KR28GSOxeQ52raROLuApoLNIw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004295;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CwmLXq/62/1T0UmWDZrUZhiTccO4dV8Xr/kNTOz6adY=;
	b=ttoptV2xFpGG21/7v97wdJrB4QJA8ng8XfTNtYWYbe+q3bjlAeIcU1Gjy8t0DIdC82GV
	 nx1mlJ0WLGZkXivB5dvNSUQWCQcYkbTCfdQPuXhu/O1kHf+g51eUtVQoi4d8J5G6R0BrV
	 UViw6x80x4VVcMhWu+2/JctLvaoC8vBlUa3tfRhjbfAOXDFYKrML9MHbqK/9pOmgAdrY+
	 7FXBjWYnWtGaMiKXR3AS3d92H+JEIeSvGL1jjP6oGjeN0aZaRrqQh1zcGnSG/8+pp0F4G
	 UFIStO87yLDeMIhXfEEJqU0n38Cpc0TcLKYNnRgeFixbUcL91A9H25CKRKDgA0+9M+g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6D8F31F031E0;
	Mon, 26 Oct 2026 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004295;
	bh=CwmLXq/62/1T0UmWDZrUZhiTccO4dV8Xr/kNTOz6adY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Xc5q6CC1mA++ZWcktVfrj06NR4JMNBJ4gtakErtSbHIsif/a+FGmOuBSZFvktkkUd
	 o3/KQAM+GJ7V73igm1DzK4EbNnEKcmLo4zPIthUClj5Bu1lAFr6nKhkLdpmH+xhul2
	 cOTbyxoIqcAK6QJOaJ2JUlpYp6KZLT6ABiEDPo4KETLz/imGZR6tYn5CpGGMjsl+/y
	 eYGvA4ParOIIZUI0+ZS9mGM4o4Q06efPIDmpl9YL/B0We0E3LdGcJ8hYRGSwfPO5JN
	 S4Cey0MHWBWMKIgTCX6gL0SmBs5hSlURy2GucvATEBYx/Oumjuzfl8/NuoahXOyHOd
	 7HrAKLSGwBGnA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CC6E744C53;
	Mon, 26 Oct 2026 08:44:53 +0000 (UTC)
From: Enric Balletbo i Serra via B4 Relay <devnull+eballetb.redhat.com@kernel.org>
Date: Mon, 26 Oct 2026 09:44:32 +0100
Subject: [PATCH 1/3] clocksource/drivers/nxp-stm: Fix max_delta overflow on
 64-bit platforms
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
Message-Id: <20261026-nxp-stm-fixes-v1-1-20a64a4ea454@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793004293; l=1278;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=L/BLJLtJsSwjiNTJzNs2bQ3gnalbIFR0HTGJUr2gtfo=;
 b=N/PIuCcPsLpSKSx+Ly1tUPcdSOC2jsr2xVHqYW0T2xAMbSOHcrN53tOzDFvZfmJkOngsoGRY4
 L8tqQnULEYTCFSsCclXrgCCSmAFRANc7OxepC788tKJ3P0wnPJQoAZx
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Endpoint-Received: by B4 Relay for eballetb@redhat.com/20261026 with
 auth_id=1324
X-Original-From: Enric Balletbo i Serra <eballetb@redhat.com>
Reply-To: eballetb@redhat.com
Content-Transfer-Encoding: 7bit

From: Enric Balletbo i Serra <eballetb@redhat.com>

The NXP STM timer has a 32-bit counter and 32-bit compare registers.
Using ULONG_MAX as the max_delta parameter for
clockevents_config_and_register() is incorrect on 64-bit platforms where
unsigned long is 64 bits, as this exceeds the hardware's capability.

Cap the max_delta to 0x7FFFFFFFU to match the 32-bit compare channel
width, avoiding potential timer event misses or unexpected delays caused
by programming an unreachable compare value.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index 6fe098a4a33f..ee249fed1b91 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -346,7 +346,7 @@ static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
 	 * minimum ticks = (rate / MICRO) * 2
 	 */
 	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
-					(stm_timer->rate / MICRO) * 2, ULONG_MAX);
+					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
 
 	return 0;
 }

-- 
2.52.0


