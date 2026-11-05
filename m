Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866729;
	b=aEvnDth+gz/hqZbYtvEpqc8PsPgFqIT3B1kR7aIU1PcbE1whRbJZrUZaHJ5w0WGyD9ga
	 /wsfVt9OPR8fBqOb+1nAKjMEQnwp+GWOJAG99b4yuxZ0Ripdy4CaqQbRIba2kCSIWLuS2
	 yFp2N93Uhq6YQhzpsbOiihqGH5CroVQUM6lhmaj4Nts7kjgJwFjK7BNhRih57Qz2MSV2A
	 8IhVYbcD0cAcIAUIfYtkek3P7f7TysijUhXcBCKjejfOkFv6jkryiW9MM1BUXFK79bYfE
	 IHy0aY/Y3av//Gx+bdOFAljYln8uwhJFonUFFasV7FrYNZmOLg4OUrJUZFZ/AkUJrVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866729;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=wMMaHhKFGPel4o9R+b5ZeHtuJGRm5DfNPq77qvI5+Fk=;
	b=Sy4xUmw9LEpK2acXXt/ROkw6WJiuA+YJKAmGkCpkP0LFE/2bkhviXRop+aKyDgEZ8sMe
	 6p7O0hydM5/Uop+OpMYJx64pi1fZI4s/UqYDxNi1Pc0lZU7f7pW39i2vpbMQNDFNWbShJ
	 DWs4K6mmFUZoPtcTO8BbzMxOdI447dBlCx9ajukjvDoYbQzjz9k/zQpJ08QrRcwqypcjp
	 PoseCb1NKnLoUYdvXZZ83PgFpz9qkj5BjgTIWNoe3GZFNV7e18G1SSxVhoF+0qNMDXiJc
	 9DeoXwGysKSTsrZ4pU193cyJ4LluxLvorw6hBKKHkmQqPhazju9dqAufYj9hibNUYlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vi5ZT4Oh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223C606D802
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 08:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3223C606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vi5ZT4Oh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793866728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMMaHhKFGPel4o9R+b5ZeHtuJGRm5DfNPq77qvI5+Fk=;
	b=Vi5ZT4OhWIQX28DgNZlIoZkCJlbekwqVe+TJnNOyHyrEtmqO5BwxB+8HVryn22oq3AyE4K
	kFtGX1thVFRTDDtqlIBhoCklqBTqx69chkx7PTZD1ycN9gMTJW0N24EEE46rXX+RlNtzG+
	Ug/FV1fwrRp9j4eK3g3tNbcbHIHKE/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-8XKTPm4OOJGqwhRbleD-Jw-1; Thu, 05 Nov 2026 03:18:44 -0500
X-MC-Unique: 8XKTPm4OOJGqwhRbleD-Jw-1
X-Mimecast-MFC-AGG-ID: 8XKTPm4OOJGqwhRbleD-Jw_1793866724
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e6e69d62aso2402395e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 00:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866723; x=1794471523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMMaHhKFGPel4o9R+b5ZeHtuJGRm5DfNPq77qvI5+Fk=;
        b=TQUPpNona/m4KAo6Nvv29bRn3KaoVDgxPC+ohzvuf5WMFiIZBBRjtLbPnW05LisNBw
         NXB6hM58bCZZjCKmiNVrnq1b/Vf62eRSqa/K/tvyS84m69sZKUTJjxtBZG+wLSRH47d1
         XWVf6XKANz57PUoCvyij+5ATH/K6/nzDVM/AT08vkZZzsvCpzOihQ1GOG8gO/2ZRf3SP
         kfYCwE2KWUANcIx2KmDXOAIHz7AbPg7JunsUwR2WO/+Ps4nU3pl0fRoYctOIwtzltPIj
         vzKDTLhcPfAfAQqUplgICBEzigs+Vm3BIhZncJNpIFKHokj8HkHjs/k1BMCMDeKQLxSh
         K9Tg==
X-Forwarded-Encrypted: i=1; AKwUvBzVQAwFge489x0QgDFhZNrpt2LW5QrISjSWeI1kXv5gbYEkeUNNvGujJMXO5cP8NtgGEeXlVaErN8AVBXt/sQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/IP+7maeO7MY61gXyYgGExeJCS7pcFQ1u4SFQbodlrAKZt/rGx
	qijh/IA8Sd4QVf/X92NOhN/nML7zJuDdN1jJaobSu0P6X8ljymWuZBbmKJ4oc85SpWdylJ0RtnM
	EfVOAxBddA2gIHBcSFIaTsBVAU3XcLkTbh2gKxa/zdhA40XnzPF+nCwe/EaQw2Nd8khgt
X-Gm-Gg: AYBFou0Jy/YOBPStLAYu7Vj8tbZU/czdzpvzHnvv0R1f3cCQZiuJ0vVZkCZFttj5s70
	BHNGlVs1wJbr+KuZWPWpvXNLNsAe7fQeicz2KJVqkq/3A2eFymPqDbRGGl5gLdVKxTU4gD+VJTQ
	cQf/rzkFR8YRNwn2oBCv2arw0dVGU3FU5xNB8GzUaP7TSNlOwINbcZHtxSHch/yu++FCkuSW8Fy
	lM97IGZGEbkXPt5yxCb60eMeWdF1VZsV74nfV6Fsc2XwRgc/MImEbrqbw3WRzUXuWc3IFa/6JXn
	Jh2mUrOy6qYzqEQ4WtiuOq7DMVQEb8HsWvwuL6Dc3ZSIyhJ/Rq3dlVtuwEr2defsaM6LBv2atyc
	tdhd1D57/kiSrd8D2YPJ6u/zg6ySzemlkXB76y1sWprpVeQ+v5PYjznA00JvMU8Pa0WeuicUnVD
	ixlLZgaejxgcpWpQ==
X-Received: by 2002:a7b:ce0d:0:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4ac177538c5mr306356095e9.1.1793866723525;
        Thu, 05 Nov 2026 00:18:43 -0800 (PST)
X-Received: by 2002:a7b:ce0d:0:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4ac177538c5mr306355815e9.1.1793866723106;
        Thu, 05 Nov 2026 00:18:43 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b63863d490sm4513405e9.2.2026.11.05.00.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:18:42 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 05 Nov 2026 09:18:32 +0100
Subject: [PATCH v3 1/3] clocksource/drivers/nxp-stm: Fix max_delta overflow
 on 64-bit platforms
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261105-nxp-stm-fixes-v3-1-8129b912e74b@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793866718; l=1276;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=3tQAzS65C+p+CwI89Nw27cv/4Q7pCmNGpT6liQLCnCM=;
 b=jaRNvqRfj8/W4VNEnG8r/OzoSDqnNebhjk7Le5MPZPZ/1fZnzaB0e9g3Nb/3xrmRC6O+hw35m
 fCu2NAhD8LSCYKJ4rEV4PM5QL7RRiLqTSmrebz0QAFyprAwC68ZJ6nd
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: znNFCntZnWzAreg0sZeL5Jfav_wGGUBqkZwz_eZFD80_1793866724
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
2.56.0

