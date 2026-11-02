Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654208;
	b=CahMPhblHPV8jVMoKEK14jtH4/5pNTdXYc3EPegR/Eduk0bpbuUx9brvAhr0SRe8V3V5
	 vY2UJdgK97NRN2TqIS50YPySSy9botSm7LDQW5E9q+jjwpEfiZeGTZo12PYk+FsmlnqYs
	 uUKaS06YIhljNFCLtXz3P0+/xNO6w37+TrmjxQdlPVbRi+i2+McJL9C/YExwynJmdugFa
	 3+EC9O+xSAq6Ov1GBoyUNtD8m2+uguX0Svt/xbJEOQF7ANIvXMUUC2nnR3BAunF+nM6z5
	 G0WRbCnPi/IXNgtfamhEUr7couS6kVVwOcgFV/ZZmFXbIipujFs5AObdgiCRcXdUY5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654208;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=NVNdZHoQPN+JOSE1vDDpIyMY0YkiFmXQ5S2CPq/BOTY=;
	b=yITbscGjRCtjKNe/Bj0JNyMb6c7m62XeH4YEzxHuh4pYQMUsYJBcCljM90p918uQv4hf
	 J4I3BBNzwwv+5twaV6brM6gqItCKebr+PWE0xbug0eVAvp+bo+rordiXHnfk6r5ZyBkr3
	 ar2TdtcX6G05OHEQIo/pSxEZngBgBjeNJ77iuY+CGZNGTx1CrvDE2GtgeiAEXsi4rnaxa
	 adF6OXCGy4jbWyTL4jy9HcBmNZtlPhP0zBGbvofrwgofCAEteYgufEg/UF14+f7g8LLeu
	 bEe8DrtIEA1yDQM5wGCf5USQyQaZ+24jpI157pFzOuJyYOfya+G4oEJf8wCA9CUa5Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLZu7teI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB592606A331
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 21:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB592606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLZu7teI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793654206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVNdZHoQPN+JOSE1vDDpIyMY0YkiFmXQ5S2CPq/BOTY=;
	b=cLZu7teIjZbAyEJwgtfHWG9xgVid6pXCGuvRcsvcM9GJCx1XgRjh5Qw8Sc0kHiX2EhMdym
	Q32jY3S/M1AdeXr3hUqzWwJpGNjblUJGHn7qvP8emTVeZC3LSB5Y0ntDVMvhdMiqQ9SpxS
	JzyhHuZonB8+xbhqRUzI5HHayLzfxSA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-ZfAxZ8eGNuSxiCXmP2pdOg-1; Mon, 02 Nov 2026 16:16:43 -0500
X-MC-Unique: ZfAxZ8eGNuSxiCXmP2pdOg-1
X-Mimecast-MFC-AGG-ID: ZfAxZ8eGNuSxiCXmP2pdOg_1793654202
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6e69d62aso4674135e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Nov 2026 13:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654202; x=1794259002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVNdZHoQPN+JOSE1vDDpIyMY0YkiFmXQ5S2CPq/BOTY=;
        b=RfzwZ0dvL22daa7XCg5gDF59A8+G31DO2IsPqs/tWbvY37TYNblDPvJW3StklAmZn7
         QMrReYNibqjadIg5x7oBlLNcfkI40KN+5/ibKi10Gw8xGqpdzrfLfAoA+GWwwXO3/LMI
         cXz4DkG0JhtEfPz/xjPP6Hg0JsM/Znyk8c4d/TgPI6L3TZl6/q9UuMZzD5S2YXUqGPnC
         +ZeHgTIY8WGt+mhLDBHOmS9dV3T+AGC5iBSA/jX/1iWpDBlv/tFHgr/ykDSWWwDOz+hZ
         TUY/8L34ZXD77TFAAwlcxh8pa10WqKxEY4DTq170aMWyELF4EYze30lQnsNq9fT2UmaV
         QG5g==
X-Forwarded-Encrypted: i=1; AKwUvBxaPuFPXIFNk6vpWpfYlveldgVSjarHfuh0McYsf+jDcwp4Rb5MBCnlt/OGSgtfh0KP8wrIKvpz5wPGVKLLsQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJYOLfxU4DayeJlQU0Y1Jy3R9Nm3+ck63Yh1SWe0CpxAAXkJNxV
	wKUOZDmIOTwPy1GszmaEhwnVFJqaUgPjBo8C7QPCeAbqg1tQhDSg8epmb3SKm1wdC+OtpOe7Gr4
	tjMSOhMOhhta8SrcsCKJ0e+NAXQS1cJNle8veY4ruuGHN2IgwIs2upCbOQeCW/yo0oTKm
X-Gm-Gg: AYBFou1ATr/RWp1QZtg/65cur6Zh3qj/DIgsRmfhn8jdqvNwM1ICg0mqR5XcK9jWbMb
	grcIzmyZyAkWcouHEhC3Nbz8YfW08RbdObhOiieV5TdMHFZfRXqGafY7H7XMiw1+n6MiIIgfDZA
	0vxiPTGhTUjB5CtNkw/eN6LDQnBCrtbfaCaaPikvbA/5fjTloejIkLd+bIaIRkxNJdB9qheOrBx
	uuBdgG65tlgY2fLtCpw4rpgGd2MspJWPH7tMJisVRlTYEd73qXFNWgf1/o05bNAQa7S87hdGJJ9
	Lj/DYfbE+oI7t01/7XKgPgSDzDmPh0j17VafZ9DpjtLYcm9fwzPyQ9cv0n1N7115j+SG6BapNPn
	4N6wuP+bByTeYl3GeA/RRvfeKFsY2d06DJ81nV+7xsAuhjaQNZ+7TbqHSN95KI1uoAipVp3VLYL
	72aDwZGPdV+SnLbQ==
X-Received: by 2002:a05:600c:c08c:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4ac12193b17mr209123885e9.0.1793654202090;
        Mon, 02 Nov 2026 13:16:42 -0800 (PST)
X-Received: by 2002:a05:600c:c08c:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4ac12193b17mr209123535e9.0.1793654201707;
        Mon, 02 Nov 2026 13:16:41 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9fafe08sm17123535e9.3.2026.11.02.13.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:16:38 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 02 Nov 2026 22:16:21 +0100
Subject: [PATCH v2 2/3] clocksource/drivers/nxp-stm: Fix missed comparator
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
Message-Id: <20261102-nxp-stm-fixes-v2-2-8ca2706f30ef@redhat.com>
References: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
In-Reply-To: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793654192; l=2807;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=kUWoWgTvYPenE4IKiBrz1IwM+AB6oxN1Q/yu3Rn0P74=;
 b=IpqG5whRDSxl3Gemnzq/I3tMvPQOsvjl6i/rI0ZXL9gB1z0N/7it4tFHtVRUPlAyMQCeZQxH7
 xIRxFfg7tweD7qacyfG/703TsKhVCLMA+IC05ckAZvQ9CwLerQxPFso
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fSXr-0UTDt5Vcb0Hn0B9e6uADwk5Ly0EZONHRqWlMzA_1793654202
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
2.56.0

