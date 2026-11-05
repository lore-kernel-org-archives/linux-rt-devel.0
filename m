Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866731;
	b=Y8HpOwwlRkM7yt1KKNi84vp/66w66MUnk5Dfg6cDPt8enm30I9WkHrInP9wzoUkSnHsv
	 1ZlSZav4z3u4CYDVmIMyYjaexmtITfSxtWLG0TurL/7YpacnE1Cu+e6j7kZYoRy5S6EUh
	 1mNtgtBQSe7uNdIJ00IyrYRzzoNx68lA7gspiyzAs18jvgqowkbmZc2QdM4+uhr7iVmXI
	 BS9qFThPIg2TTqNNTi52UPVCrubWaMKVPFyG3+zxxVrWG1BE1plDl7o5E4UiyC/ASbDsH
	 sftlEh7JCSASS++FLl9TL4Kdf7Vatdr3b9TZGklICl9bSbzXcXCxihQkpkeHcpWJ8bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866731;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=QSh3FZ61lDmn3YnE+4HHyt0kXFsbYoPQ+T2xj8w5o54=;
	b=mBPYD/BjzZvh2NTgawOazYBe3B54c470M44+toTyHe/sWitvrLDqk0pFZ/1NhKuELl9F
	 ayCJFxty6oSXix06yhrMYYOgRhf9OdRCSKeFKVrmS4YZKe23roFhsp5POLdnMGMlvyiq0
	 nqngfk3ZyK2+dKGa2Y3/H1pGEddM7CS2rxRhFtSWFAgj/iNMw+6NRXNoO5E7MJKQl2b1p
	 8mJLGXhfOPWFwFzIC9Qnqs9PBpmCZRhS44iDejEZu7wnSgA7+2I7ncc+sPb8AIKnDTNMG
	 NdoVs93/jVP6HNEYJ3OQBG5DnQ40uNIzpinANHesWK8MGXlHSuRA6VqWhK2svj0A1MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wkg1WMPk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1F606A328
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 08:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4B1F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wkg1WMPk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793866729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSh3FZ61lDmn3YnE+4HHyt0kXFsbYoPQ+T2xj8w5o54=;
	b=Wkg1WMPkaTmKcVFv8SjVZ3Fm2+Uvn/gzhBZ8TdPAJBqY0gBMLeDgHG4R1RsTq0EA/09iYe
	po3ecNtN6GskHWbcmxP75E3yP9QwCq9qQj9R65GING26EEcxBSpEPhUzfKm8r3D4Z0UdEv
	EBFrKLpedG+wgqISq2mg7bKLnql8epI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-p1sLjerfNa-Y6qoUP7fa7A-1; Thu, 05 Nov 2026 03:18:47 -0500
X-MC-Unique: p1sLjerfNa-Y6qoUP7fa7A-1
X-Mimecast-MFC-AGG-ID: p1sLjerfNa-Y6qoUP7fa7A_1793866726
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-491330c5523so89044f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 00:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866726; x=1794471526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSh3FZ61lDmn3YnE+4HHyt0kXFsbYoPQ+T2xj8w5o54=;
        b=Zu78tL/pMbffvCca4xK60Y1KYrRMDnjmBhmwDX23+XWwleGXzhcKdORBrGMzF/Y8JQ
         qPoYhLi/32kj+0whaKT9QGB3Tlmb417qUNcLvF9YBB53KYjwMVT8MAGjxpEtCu1ds5XH
         6N1twtiahYPjfBWrS6n+00CbatVvemmlCOgnTPgscgL1aiVJWHATaSet5wUdB9l8nGtn
         1N2Rq1BApSr+iZXvFQrScaKFH5C5wdD/t0BrX0rT1f5J0TZYXMv8Nx5cR6J9IwDR0Utw
         OSLiOKGwNs04vBwB7ZSoaehcEh0jsK0aqTy0tg4JkupTt9S3nTdwVJAIyuRMTwDRpf7p
         sNbg==
X-Forwarded-Encrypted: i=1; AKwUvBzYufnnEATqwi0Zl3IUZmI/LvdyRZd1pVK3oISsWQw2wzP50zNCBWpaIDi7TWTWhfL+kuoWI5bzKA69vkU1WA==@lists.linux.dev
X-Gm-Message-State: APuU4Z96RwKhIYZSiMJX0qXpIAZN426Qr6mDi7VMsXSQP2fol5Vpy0Ci
	+rhOeepyQZbNbYdy0bLgUXuvQDBlKoYgQCGWBJZxjmN17znZuThUzpzMHLWvZVAunmvHbdTJWDh
	msLtNGvdNiu+p0RcwjVNwgKjR8r6stGeZnoDl7206y9djHJTFWGsJoQJjj6j+nFwcTSIr
X-Gm-Gg: AYBFou1zYUUy16FEfzvyIWuL1SCeKK+8NTau38XxYwxS+v5UqdCt1/+kCudhM2q2Ibw
	EWNBxv5YdIeKdO3ac6NVssU0FCV1x+5F2zyG09vdxfq+S0Mn2VYi3iKbeC+O5snVARn/NhH6W+n
	PvtMO26JIcgxGJxufQSCQE08klRt2HL8HGVvR53gZo3xOratAC5ChBdobsT6Y5Ty3ftkdLiBU80
	iyjwZhmgjBsS7U1ya1ZsafEgxYWFQsdlQHGwpZSOuHJOTpxS4WX2h5VO6NbG1v3lGFZUd3a3Q74
	0CJXb+pprmokgInTyRm5YjhLaRG9awaRoCtSIh7vZ8el8DTIA3v1ZJOvnPGtc9UXIbgr5Kv/uy0
	I3XXszvBK5ZC+SyQQegPhcKNBh/PISqmlgx7ct9f110RO5SBuRH6f1CsVOA1vMt15vI8vB1wzbi
	IFnknMoAYIO46q5g==
X-Received: by 2002:a05:600c:1798:b0:4a0:1f9e:5f78 with SMTP id 5b1f17b1804b1-4ac1228a41emr256213075e9.0.1793866726015;
        Thu, 05 Nov 2026 00:18:46 -0800 (PST)
X-Received: by 2002:a05:600c:1798:b0:4a0:1f9e:5f78 with SMTP id 5b1f17b1804b1-4ac1228a41emr256212735e9.0.1793866725536;
        Thu, 05 Nov 2026 00:18:45 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba0f3sm44809715e9.9.2026.11.05.00.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:18:44 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 05 Nov 2026 09:18:33 +0100
Subject: [PATCH v3 2/3] clocksource/drivers/nxp-stm: Fix overshoot
 detection in set_next_event
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261105-nxp-stm-fixes-v3-2-8129b912e74b@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793866718; l=4750;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=SfBQfG5mlmibe1DcTKzD+JsL6HElJN8/ugHv0KDBhSM=;
 b=hhPQnLcN4q07hzTusiQDClj/QCvvst7v1mFKYKmIvqGnjjFcMs+XXcftGeKP7p3kegMMr1oWu
 I2BB1+q+URHCJ1Fy/H1MOdHbH13htNKxeLY5Sdops2YsB8BLWxAfOiS
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MS0b5l-jG1ql2nxhxbm4Jb8e9otq0371jO9fowk4ku0_1793866726
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The existing overshoot check effectively compares two counter readings
and only triggers on a counter wraparound between reads; the normal
case where the counter advances past the programmed value during the
read/write sequence is not detected.

Replace it with the approach of hpet_clkevt_set_next_event(): read the
counter after the comparator write and return -ETIME when less than
STM_MIN_CYCLES remain until the match. Derive the minimum programming
delta from that margin. See the cover letter for the measurement
procedure and constant derivation.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 53 ++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index ee249fed1b91..81527745b7e2 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -20,7 +20,6 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
-#include <linux/units.h>
 
 #define STM_CR(__base)		(__base)
 
@@ -52,6 +51,17 @@
 
 #define STM_ENABLE_MASK	(STM_CR_FRZ | STM_CR_TEN)
 
+/*
+ * The comparator fires only on an exact match with the counter.
+ * STM_MIN_CYCLES is the post-write overshoot margin used by
+ * nxp_stm_clockevent_set_next_event(), following the same approach
+ * as hpet_clkevt_set_next_event(). STM_MIN_PROG_DELTA is the
+ * minimum programming delta derived from it. Both values are
+ * empirically sized from measurements on S32G.
+ */
+#define STM_MIN_CYCLES		512
+#define STM_MIN_PROG_DELTA	(STM_MIN_CYCLES * 3)
+
 struct stm_timer {
 	void __iomem *base;
 	unsigned long rate;
@@ -248,6 +258,7 @@ static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_e
 {
 	struct stm_timer *stm_timer = ced_to_stm(ced);
 	u32 val;
+	s32 res;
 
 	nxp_stm_clockevent_disable(stm_timer);
 
@@ -258,16 +269,26 @@ static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_e
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
+	 * The comparator generates an interrupt only on an exact match
+	 * with the counter. If the counter reaches the programmed value
+	 * before the write to the comparator takes effect, the match is
+	 * missed and the next interrupt only fires after a full 32-bit
+	 * counter wraparound (~32.2s at 133 MHz).
+	 *
+	 * The counter read below targets the same module as the
+	 * comparator write, so it can only complete once the write has
+	 * reached the device, and the signed difference between the
+	 * programmed value and the counter reflects the hardware state at
+	 * that point. If less than STM_MIN_CYCLES remain to the match, the
+	 * write might not have made it into the comparator in time;
+	 * return -ETIME so the clockevents core retries with a larger
+	 * delta.
+	 *
+	 * This is the same approach as hpet_clkevt_set_next_event().
 	 */
-	if (val > nxp_stm_clockevent_read_counter(stm_timer) + delta)
+	res = (s32)(val - nxp_stm_clockevent_read_counter(stm_timer));
+
+	if (res < STM_MIN_CYCLES)
 		return -ETIME;
 
 	nxp_stm_clockevent_enable(stm_timer);
@@ -337,16 +358,12 @@ static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
 		return ret;
 
 	/*
-	 * The timings measurement show reading the counter register
-	 * and writing to the comparator register takes as a maximum
-	 * value 1100 ns at 133MHz rate frequency. The timer must be
-	 * set above this value and to be secure we set the minimum
-	 * value equal to 2000ns, so 2us.
-	 *
-	 * minimum ticks = (rate / MICRO) * 2
+	 * The minimum programming delta absorbs the measured worst case
+	 * read/write/read round trip and the overshoot margin, see the
+	 * comment on STM_MIN_CYCLES.
 	 */
 	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
-					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
+					STM_MIN_PROG_DELTA, 0x7FFFFFFFU);
 
 	return 0;
 }

-- 
2.56.0

