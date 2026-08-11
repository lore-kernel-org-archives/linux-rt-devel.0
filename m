Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125AB3B71AB
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462884; cv=none; b=b4QOFP2VAS4MkU39cCp2am8LWiKMTmhhcJhLDlUdxoRthKMCVptD0MiaR5bjS077xiYxBIMHL8lqUYdRSmnJutYM0vimCR0+XMwcdoddSI7Z6uKSfJgV1xXcEH/37P+WDyjLK8WLQlDo5h9kJD8fPNIpFoc0ESPNVkpgyFMpOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462884; c=relaxed/simple;
	bh=BY65PnGHe+xwImPtdzo4MD/Fzu1+CVIUf4+17OVN5LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5kqu/09RZV6Mnx6sDhCedC9qTroSPckpzBTBhLdCBgrOMtSmAJwD07ec7yazV7uLzJH+DEOJzT4kpJuh5qWqVhjU/VXTh9p2A7GbKQKsDqp7F28KG57boPx4+GtqaN4V/YVuB83eSPUN0N5yVBhI1inB9VcchT8BiIyPWkfZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKlY3OgH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKlY3OgH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4994c49f588so184365e9.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786462881; x=1787067681; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/5d17gGChZeOWSRVnJ05Evry3YPUBU8qMwLcauaTRc=;
        b=aKlY3OgHl8hE78yTMny0K+Jbxl0zDrkq8UwqG8zfACoWZaEffFAXf3Jn3E4BPy3NiA
         +O+wO4tRdvBpZil9d4VQEZGqGyLTSPDsJc+idINdVJWrc1QcrkZY2z6t1G59co+ZQj4c
         PGuxXrV2FGi6VpnkGpSiXCnXpHsPUd3dQ4/NyCPp0KKn2K4QuHfwGuQSFNuu9YsmLfe0
         BxSb2LzxnK6dFhFKMG+QV2NOJby8R1je7dMxXvLGSfle0MelIABXF1iLSPTft57y2RO6
         mvhA8a57AsAU6OB/8BMDyccFzP6H6wsK7G9IdY4zsnN4D6j7DX0MkKRpBHKQLI6IxrKm
         O7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462881; x=1787067681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/5d17gGChZeOWSRVnJ05Evry3YPUBU8qMwLcauaTRc=;
        b=Yfb9S6bgYbv27BbQuuS6w+ANJpFIDFm5fUDWZNmDSjS+ymXBN+vtXrf/bM1H2ncsdz
         Kz84J5NSRPcpcOaG4aWQorDlLuiX84G+LSwwGsp7jLPawKuGpd8OcGBMudICCunZIcez
         BSv+qll5lqo+aoe5kOHfiuTkkR4cCrVIT6H7w5jz7HbUB3806I5oiU8bNnRPwSglt7vO
         HuoCiNCBHiBRiSQUIOUI+Z6sVXWZnfvp1w+l7pz4F6l2pdLo1o+WCdZLdM4dQdmBVog8
         nCX2yhhUY2koLXugxT7zLzh25K5NiNOOJ9UuJOkI/4Xt6ypb5vJuDiHFZClTjdqalYuK
         a/Bg==
X-Forwarded-Encrypted: i=1; AHgh+RqCZw0eOUX/PP9T4DQaZ3R6Piindjroqj5WG5njoTMgD5BrP2JextfSoQuQaFmx3mZeagwZqATSbql6XoDuNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFN270jTzlvdiihOf/7Wjp2P2ZYM21iKv5Vs9qT0oMaHkJX66M
	uXB6dOUjxZGSmx8h4OcdvXXo5h3zhJK/gYRipQqL+DGuaWI3PlzoSvra
X-Gm-Gg: AR+sD127JIp/pkfcrOUhtnrQGTAcg4cM1OHkmq3sdVf1OHyiRyCE63HSRR79LwZoFZj
	htg5rj/9RNwtTaKSyy78CntmBQms1p0DrecO5F/95DwYjdQzRIVFr1QncOh7mYM5TWeZHo01N/q
	e/MsFXvLhfMOMgVOlOXmYrau3YYidjcFoVsLTy7vwuRt9Qu8TZDlKYYGLESgV0IhVdg/7KVkVzx
	6P/sc3fDmB6plNlyuG/0P0CHMSaVMWgYPHaD1HbGBqrseIIHShDQHfQZ6A/oX7kpjITKadL7Nbq
	sHFVor17ZLb87kbTxsI039D7Td5XflwXM9eKjtcwas2FlTZQHu97QNTxAJvPFPkhCs+xUdnmHiE
	nIX96qzMLIKPw4HbJt8s2PfeqYhQpxivdTkKR4AOkuuYt7KFm1eCmM1Tk3zJDdJlIH929aqKKez
	q/AzGULWilQN7HF7D0Em74+TTCq1/6ic1UAZGEGVsO5UmSIGAUUF6MJ74zK4EYvN/jUOL7YV+mj
	tOic6m7+uduGJrUGAbWSDyo8FwcTj5R3mlW8TCLWw9BQJsgp12NJu6ZBrNROTLMbk14p6UPkgsW
	8iKF7XaHNl+W63HEV1Tepmvf2IIUj4OsrYDt0oBa6UFzDfQVRQjh4sZCdTFjufrXS0zM
X-Received: by 2002:a05:600c:a41:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4997a66e371mr16160195e9.0.1786462880721;
        Tue, 11 Aug 2026 08:41:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa7aabsm1670275e9.7.2026.08.11.08.41.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 08:41:20 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <include@grrlz.net>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] kcov: Use unsigned int for kcov_start() mode parameter
Date: Tue, 11 Aug 2026 17:41:06 +0200
Message-Id: <20260811154111.64669-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260811154111.64669-1-kmehltretter@gmail.com>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task_struct::kcov_mode usually holds an enum kcov_mode value, but it can
also carry flag bits such as KCOV_IN_CTXSW, so the field is unsigned int.

kcov_remote_softirq_stop() passes the saved raw value through
kcov_start()'s enum kcov_mode parameter before kcov_start() stores it
back into the unsigned int field. The parameter type therefore does not
match the values it receives.

Type the parameter unsigned int, like the field and the saved copy. No
functional change.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Notes:
    v2: new patch

 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 1df373fb562bc..b5340369e6fe3 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -354,7 +354,7 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
 #endif /* ifdef CONFIG_KCOV_ENABLE_COMPARISONS */
 
 static void kcov_start(struct task_struct *t, struct kcov *kcov,
-			unsigned int size, void *area, enum kcov_mode mode,
+			unsigned int size, void *area, unsigned int mode,
 			int sequence)
 {
 	kcov_debug("t = %px, size = %u, area = %px\n", t, size, area);
-- 
2.53.0
