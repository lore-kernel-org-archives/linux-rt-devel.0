Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B735C6BD
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970430; cv=none; b=bBC2LcKHz6tW3LXwN28tG915mrLmM7tlLYqcECDghbDI5HXkSE822Jogyrkbs9IDLogMO7bU9noKYol3thFVmtQWy1e73GgNn3uWWlQsNYobLrIa2l86qvZ/kKqC+l3uvDaxlgY19huDF5R8gb5+JvRhXn9LeJ0pyna8jtqNW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970430; c=relaxed/simple;
	bh=onN4wmQ3R+mhzbGXit5pCMgHTHvfkzs4ty0N89GJZJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lRj8g1XoXXU6d0RJnn0BsSJQOAL+zKhcLFccWoAjzmt+sl7/WISZe6usAhDS3kwj6yB4wwXUl3t+YoUAahAQk4xf8dvqaniBrHYPlLV099UHBm/buGRCL+NNKwpMz6PaWz1w+tpIUTBGmuxhZcLRHhjtAvDMmF4gYrDIaQHFf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvCxxLz8; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvCxxLz8"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so14249025e9.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 20 Sep 2026 23:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789970426; x=1790575226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ro+FMNk45PgRPb4vSmer/o4ptFIHYgVUebCic5ooA+w=;
        b=UvCxxLz8JYUoa6211GFOWQwZHWNXbbzZ+Cp16kUplbQ7T/ela0iHSIaYnWTuXdTtPz
         63qsEvPYqRQ2SVotm/Pd7eNgKho4i7RMXeGHNz1Uddg4BNRyaB0wuJ32I/BXHGUwsMAF
         cnLMEKKuY7TeeSgoN6FiVkfqBkfouUbKokU6o3Te5ctT2G0t97CPgyLHcUfFWaYtiP4x
         mg+xuPyRflXHcHJQR4ZlIi7hkKxu3lAQRVIlo7MpjMLp1mHqD2gYFNJnDN3rT7VoArSU
         1YLv+kOf4fmsyH+bMsld4tBF7uHCL81b7QjfJb0QZwIyNvWCMeO4R4N6uOLysIImtE4V
         rxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970426; x=1790575226;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ro+FMNk45PgRPb4vSmer/o4ptFIHYgVUebCic5ooA+w=;
        b=o9EGVe/6sVjWpI7+NgB7fy2v0q8uJSrWKAy8J64RdiB3u+Nsu+x5/AuaEzv+ONWXv/
         zoNJkpNIXvjSaUN/CEMzjUI8VxloJk2qIyYHH4UfGqhqQvMfh9gRoFoAHM1zb9TFyLlx
         pdooh9SFdwBA7pJ8T18jDox8ZSpigZf132Kwv00hyhTGJPcs2kLQ18vjDcvmOq70C+ZX
         J/2GVBNQH+h/eoPsdUnp5BoVBHqPeVfrVtE/veoiDqi1OAGQiVoq549KGVn2Ivky8XEp
         YLr4S2FCRcoTUIbLyOAjiVJrda19ZvANH4funJlGK4+pHKPvAf0f1gCjNjwFvhJQYb5O
         BJzQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1wqSBE/tOlJ2tHn399YvtSrF6uaGFm5DdFs09f1G80O0Q/MQSQ8kHiq3YhL2eHFiainCJK7BldEXKHtfhKA==@lists.linux.dev
X-Gm-Message-State: AFuF++mq0aqunJKde3gjl40g4rBWwM5nnzu+l/D4CwTvTGwew/c5jMXS
	95FInh15Eq6on7yXPpzDAyRQKpbdtoCcgA0c3pVF87UvQz6rxIpNJ4SP
X-Gm-Gg: AYBFou1adj991xPfNC9ZKFZidLNNbhfGVCIzpyqKjH8hweE841I9QDPE9omaSAue9j3
	E5by8IUlCTtEfj6DRBANAEQJvH2NwhkBCDTF6ueJ7yx4xvaBRRY2z2VZPKuugXIDL95y9X9qD1q
	F5NoJ2vVxDpG65bcAKXgVD/zZQuby20v6gJ9IlvSYLudJ6j0k1i5qTS0DRSRKtKbrKDUfYgUyjM
	5w6p0XzU9jT17dcnv7/8JRnVMnCK6dFfhz9CKFdzjbX7lHjFJWU7HRBuo5McbRCUDC9U4cO8QoE
	RPvUwpiiwBh80IXbp8XeUpuNIY6YD7GKrJfCFMfvHzt90X5xR5OFZF6/jcUKjPG3UvRhvwC70Bn
	ZSWDG+DTuCGP2Gc/RR7zpjYAp+Xdc7pgVRI3YrOF1tLHyb1d5GoKfms3ZQSbNzRXoWAcyFgFMOC
	e6ZEm7on0fpCZzs2D0xcAFXwpTsIFfe7EDrl9ylY2AjpfDi8ahmzKz++OTNfrhGB/B4KQuP347f
	Mux+4lsoU0gOZ0g4ilsmcvom0OxJ2xqxN5y1N/beVMu+FoZSr5ykSVzXXIG4933I2qiSQopgpNU
	DSCmKYLdkurr4v7JDIbbMVS2rABVZ2NCCG16sI1gVEHgxxgx9MSWqF/zuSAnD3zFeBO+c/w3Bx9
	mCdtCVxyCEaI/
X-Received: by 2002:a05:600c:6305:b0:49f:c2ef:cfb9 with SMTP id 5b1f17b1804b1-49fc56719a8mr103694715e9.4.1789970425753;
        Sun, 20 Sep 2026 23:00:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-f941-243b-87f6-e5a2.310.pool.telefonica.de. [2a02:3100:a8e9:c501:f941:243b:87f6:e5a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1149e0sm198706585e9.13.2026.09.20.23.00.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 23:00:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: cacheinfo: count external caches in early_cache_level()
Date: Mon, 21 Sep 2026 08:00:11 +0200
Message-Id: <20260921-arm-cacheinfo-v2-5892c4531ad9-2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com> <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com> <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

early_cache_level() counts only caches described by CLIDR. An external
PL310 is absent from CLIDR, and its arm,pl310-cache compatible is not
accepted by init_of_cache_level(), so early allocation falls back to
an incomplete count. init_cache_level() later adds the DT-described
L2, forcing reallocation on the secondary CPU with interrupts disabled.
This defeats early allocation on PREEMPT_RT.

Use init_cache_level() for early sizing too, so the initial allocation
includes external caches described by the device tree.

Cc: stable@vger.kernel.org
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20260912195552.76673-3-kmehltretter@gmail.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Fresh full-series rc1 retest: three builds and seven QEMU boot/CPU
hotplug checks passed; see the v2 cover for the matrix.

The detailed testing below was performed for v1, before this rebase.

Without this patch, patch 4 keeps the warning on QEMU vexpress-a9
(4 Cortex-A9, PL310): the early size is 2 leaves, init_cache_level()
wants 3, and init_level_allocate_ci() reallocates on the secondary
CPU. With it the warning is gone and the cache sysfs tree is unchanged
(L1 data, L1 instruction, L2 unified shared by all CPUs).

 arch/arm/kernel/cacheinfo.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index 860eeb03cfe5..31591c947254 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -111,13 +111,6 @@ static int detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
 	return 0;
 }
 
-int early_cache_level(unsigned int cpu)
-{
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	return detect_cache_level(&this_cpu_ci->num_levels, &this_cpu_ci->num_leaves);
-}
-
 int init_cache_level(unsigned int cpu)
 {
 	unsigned int level, leaves;
@@ -146,6 +139,11 @@ int init_cache_level(unsigned int cpu)
 	return 0;
 }
 
+int early_cache_level(unsigned int cpu)
+{
+	return init_cache_level(cpu);
+}
+
 int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int level, idx;
