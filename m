Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654209;
	b=MZx0mhYdrjkU+mmM5gZzC8ANxPJDW76SofzCpx5mOEX/ZlishRxywerIZvxNd5CyOBAl
	 JFXcrDXnOatc4LxmQNfVWYCS2XxpYnkFPd7H2yOlZNsxT8qkX1GIIgrnsFkqpW/QCI2+E
	 kt7Od5bN32YzaXTkB6jHo91VaobL9p6r8/4S3QA87hkeMowRwgWQQoNcihDb5XiF6I73f
	 /oM3mqyuKVQz0GsBLaGut8CqGKzX+ytrBX2FWyg1OBn9+6+zuQbOgKaTAq+hFQ/P+8pvf
	 TtdXKHjAENIqiujn2mXfMruIun430ZCS+SBjCHA+QtqOK8vx608pbVjxZl+BkKPQTvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654209;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=2RjoLq/kIZomTqqU6zUcn3juKCDy3taGhnxzS/BtlV4=;
	b=WlE6VKKD+HCuhUlYGYoYIB+f3IZANQFQFwFrS6omct6HCXHnJEqnCM2sVhpuFhWq/z2L
	 EuxoTau/ulG1ho8RBp89szRVRtF80MeKF9KkQI8cXe/4pvtb0PkABaa3+hYhjgFgWog+h
	 90lRCMe4IUVwdzBSN4J5zj8N6/PHDM8Y4oPMF1JQKMKLI+FSH5iHOrRVcmiPy9xsUhr/h
	 1pTHw/yDIhfy6mfhzdC21fWuoF0i4tGE0tqEh2ZlkHneYT9ur9Kgow8wWZZXUh7u0EShn
	 SIElrS189fxllHYXInfUgsoqsogmYQ/bT2pKsgrfNYVIfAYYS5DTNEGkQ2vFEGDVdvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FhuuvEBp;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C07606A32E
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 21:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9C07606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FhuuvEBp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793654208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RjoLq/kIZomTqqU6zUcn3juKCDy3taGhnxzS/BtlV4=;
	b=FhuuvEBpxbDEg3g6AX0BlEspK9HUBOrToIGfIpxeChxTEKuq8thiiUy2PMORA2WikHluY/
	sA8psPgf7h2Xd2vyW0py5dEEosksgcnwxnX46FP/dhugIhdKAD1c815EiKHK+3peyZG+gn
	yiD2YQw+82CEXUCRYS8CAsvab2H2YUk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-24EjYhA2OTaYvoCRyY9vug-1; Mon, 02 Nov 2026 16:16:44 -0500
X-MC-Unique: 24EjYhA2OTaYvoCRyY9vug-1
X-Mimecast-MFC-AGG-ID: 24EjYhA2OTaYvoCRyY9vug_1793654203
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a47047a7daso3559995e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Nov 2026 13:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654203; x=1794259003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2RjoLq/kIZomTqqU6zUcn3juKCDy3taGhnxzS/BtlV4=;
        b=mdTP+h3SA6IXj89nqa0TBAaMmT9f+7buN1mn7jrbF+fjxE9ruQu3LKyQAozx55I36c
         I7r+IVY4KZ9Q5BGxN1KTp6pnA7eS09IJfMLNmfD0ibve6VQ5hPbtVcMTYpVWJb8qfDFF
         nSUWa/w/9utqCTHN2+r0SS1dbau0mXAN55Y7UbORqd4NmzpU8B2CwcPypCye21ZT645c
         d2EzehIyIvqdRFaKhAK1sZGXSLKiVVVgwvCZEINg41dMWoqaUSMYoTUkYr4QJVVNWfQG
         7dKtBz4U0otjwMtlnaEtjwH0vMxtBQuN8RwgTrbLBOmoNGMaK4hIqTg9i5Jp9z5fvIAs
         cB6A==
X-Forwarded-Encrypted: i=1; AKwUvBxr0kdJWfgi/IblHTACFkn+jBQFvQtTsvG7vGdR3bW4pu+fmDFD3hESsebsk90zbzauxFH5PSMp2Nv/8aUuKQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJd14hphkofhEC6Nus8vjRvj2WAD3ULU/dLS1dmGMz4S1F5BZIV
	KHF/XsRK0+zuzZjOe+Nzk88B70q6PCaU6TQ8O5dJHPxnwpkktG1899nc87Avxh3Jn1+7Lz7u28v
	neNelSWUkZjxO3m7il/gYgymxho2eNuEV1H6Bz4spmFeJFxpD5uFZmedna5xioupxKwBR
X-Gm-Gg: AYBFou2jh/F5vtfHjN61mq2oOWWSg61S7wv2mJrrG/TjUjPPVK8nzPza+ceMeA3B6cj
	LwVzAJucZGoF9G0Wwb9k7Z3PuckKAqh9GHwsOdxBVBOCR2ZCQuHZ9p3uGEfQ4XhBZJQ7rHW4FKd
	ICBxSt2MbMTIdhGvkxPuFPX36CXb3zPkiGDIznfzamCgALszgMGVuB2OoIxzG2eDHlh9DvngKzp
	OxCbJ6ml/FjP3usoZFs34YhGXj82PZ3FO7iKd4O3Sn/X4tFgyMLZGOmnNnCf65tLXall2difdtL
	g5espx4Tg+3jd0lzqvFAbOIYb2BwZRDtzg9d+gghAv0AZpnaWnBnhgkJLlaMqi/YiupVJSESldO
	rFt2lZCX0QpSVRXD/BXiFNRrJjy2UWwmUlGEajFOQBrA4LNKg+kV0OZ1BtWNWi2MXI0h6HDqsy9
	jN8uHEF735FrlxMA==
X-Received: by 2002:a05:600c:c08c:b0:4a2:1a:a115 with SMTP id 5b1f17b1804b1-4ac1209f120mr218821515e9.0.1793654203518;
        Mon, 02 Nov 2026 13:16:43 -0800 (PST)
X-Received: by 2002:a05:600c:c08c:b0:4a2:1a:a115 with SMTP id 5b1f17b1804b1-4ac1209f120mr218821095e9.0.1793654203128;
        Mon, 02 Nov 2026 13:16:43 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm24999655e9.14.2026.11.02.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:16:42 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 02 Nov 2026 22:16:22 +0100
Subject: [PATCH v2 3/3] clocksource/drivers/nxp-stm: Increase min_delta to
 20us for PREEMPT_RT
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261102-nxp-stm-fixes-v2-3-8ca2706f30ef@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793654192; l=1953;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=9U7e/e2EyDS47BqXM0Wq4E/IVIq+iDMzJy9Mz8G/8z0=;
 b=I3diUql5Q6GbqX8veSUe45rbF94jf6KgRxB2o4ixEqSLRhaEof0uU+OQxrTWrQXV/bTJ4ErDo
 +5AE3K8aDZ7CcqtoXD4Mb0PjXDAxuRMGD18t/k2lWRpFU20e7nZ+1KK
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7i_x3bUYpRk3cWKPXxUHDc8aq6rLhuD4iHpPDsmu9bM_1793654203
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Under heavy bus contention on PREEMPT_RT kernels, a 2us min_delta is too
tight and causes ~32-second timer soft lockups.

Increase min_delta from 2us to 20us (~2,660 cycles at 133 MHz). This
provides sufficient margin under severe bus contention to ensure the
channel-enable write completes well before the counter reaches the match
value, resolving the 32-second soft lockup.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index ed7662a4e2bc..a1a0e23d3342 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -335,14 +335,18 @@ static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
 	/*
 	 * The timings measurement show reading the counter register
 	 * and writing to the comparator register takes as a maximum
-	 * value 1100 ns at 133MHz rate frequency. The timer must be
-	 * set above this value and to be secure we set the minimum
-	 * value equal to 2000ns, so 2us.
+	 * value 1100 ns at 133MHz rate frequency. However, under heavy
+	 * bus contention on PREEMPT_RT, 2us is too tight and can allow
+	 * the counter to pass the match value before the channel-enable
+	 * write takes effect, leading to 32s wraparounds.
 	 *
-	 * minimum ticks = (rate / MICRO) * 2
+	 * Increase to 20us to guarantee the comparator channel is fully
+	 * enabled before the match value is reached.
+	 *
+	 * minimum ticks = (rate / MICRO) * 20
 	 */
 	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
-					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
+					(stm_timer->rate / MICRO) * 20, 0x7FFFFFFFU);
 
 	return 0;
 }

-- 
2.56.0

