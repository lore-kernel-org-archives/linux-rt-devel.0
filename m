Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795249734;
	b=zlyMca7SSTcvclAa7S8KvT63IuRDmcXJUn4vXskv4rP3DOaVbRHcn+6E3rosoJ+hwPXV
	 PDzgwyAj8p6V+BEaon8BMcC/UW+HmYPUXTSBpqLNxWDXxBeF+g7TIpMya72F/4JG/AnTt
	 7hkiT0ypCMc3zvHzn//zYZn4999P/vDwGyDKtXrjwDg9Yc+dh+4RcmlD+qFrxcrWXzp6j
	 QPiUBo59l4pzVaNPf8N1lPs2VN9qyEnQVEipPfmsOgxJk6EnvCWKAzR8vxvlEaGSW94P+
	 9m50fwj39No2yfG3zWcotSY34SKpxbDbYLZfxTJtdAoJpaQ9z+khepd845vKpBHN8Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795249734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vA0VgrN/AJbvlL7DFILZtRf61HlqOG1LXfr01uh4umc=;
	b=VCC3SXMqSH+ZXFV6U6Zzt2MXr6ZYRz3A5WFIAjfnrMrobPp/l794a8EAejmQ7BGBTcfS
	 12bxmlVQGXjooWgmw14XbT9DSmeA4uT5NGByNTKv0KxqM/XNV7SueOEJpQY3bRAnJdezA
	 llbnYKXPwM8tEalBbR4sg1wvOWVovQf/PxVlG7OVLKLvrEusulmauzPC5Oba3bKf1Q3ms
	 in/qgjL49hLT+glNjmgCIrQpN3BE0vepXsHfto7m7sq1sJjWjRHVhe10NafOiiPWoE6dE
	 CJXodo+h/kBnPNImqfOql0CFwqrB0E5uGJKfGLqIW+UxDOQZ97CWmHICup6CD06YevQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKbbLBa9;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E54606A320
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 08:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80E54606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKbbLBa9
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a42b34e930so1416919f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 00:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795249733; x=1795854533; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vA0VgrN/AJbvlL7DFILZtRf61HlqOG1LXfr01uh4umc=;
        b=qKbbLBa9hyvrpIGg/VvXJsFkF8eItMeTzC1t/aeME/fHoxO8HmSQ+verWFAG2pDAZ7
         1a2sZI8GIjLo7vCEEiMCwg9+8sku+bgA9WVSaSbF98LYMdkwtSifc2KvqlMOedQ57sz4
         Z2Loh2ddRZ+y4zFmaWN3GYQXhZ8dm5cTTSUwmQw0veUiA440U+dDCkkBmiznO5VxtYgS
         5A4dHNJU27rnuPTo+TYlyis35NKe7HytRIkDczi9ns4X0S5h2EyerOskO6/IVV4y0M7g
         WRD8fIj2sIR0fB6DFctja6OxouE4h4F0wq9Iv5PqFV6P9+FTC8BkBQIVp2DDfOxtxtoH
         0ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795249733; x=1795854533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vA0VgrN/AJbvlL7DFILZtRf61HlqOG1LXfr01uh4umc=;
        b=vbj0+qaHZxh7vZ14/Nnp3wmdWyxAqHqccHjTanDVrN+xmwx8nfBNrQfde66ZpAE3+z
         pcYdnYOjGX6FXzygWKwlNSQuJAk2CNOw/c0k33KcJuU3qOtC9OE0mCJ/UWrrLdFv9PYY
         Dptb//aGpP9/wEKbjayLUT9KrL2g218gncmT2y6oN+hN414OenTOLEQmYNEQbBDCfqVH
         qqtBOqwH9CLJOOI7Ith0mvvP1UXJjSz41jSUk+AOT/fdrB1KxkfbMeNmXO9QImdasjSU
         SJqu6lRBuz+JMSwykgJ5VveFT3q3rvL77/9dB0OqgnnV9g8cvyS8yIbb4+QkUTVvcBCd
         yhNA==
X-Forwarded-Encrypted: i=1; AL+hErEbBhCDoY3SKyCmz3jWTIQdfoUeLlfIyAvbNPJKnrkiuN2Ccp5jF9EwHd3tuG2X3aAejEvz2vo1EY5csFTIkw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Sq094ZL0T1bIuRRvj2Krwep/WSA9Dshx7u8znI/c1xWPN6ysm
	lWad2KB64oEpRZ7Jpeu5RZAQMej5niEKEY1ShtQiQOGSK//n/n0Jc/yP
X-Gm-Gg: AZFdTZdo4Xi7WHc6G5egXp7fg/+qPQXszIULu5WHqnbo3o0rejq2bccLCMhAg8XJdCb
	7tGR/D7ZgmW9GvxOMoo8H40xSaykFgUd9KVc7nwzNkYuzRZzN9bEK+TLOU7NM/jM6CGIE/c8NdK
	i2XJ45a2L/Vh+tFSvGMMlJARa7KnoKfrxm66szcjl/u+vhSlUcvdOGdvV7ihnKK5tuBQ30bGYkK
	VY/LCCkkZGw7SmgJvwlKMOf43FBZHT2PPoLnp5Rw4iBhjHSSuaiZ4GyodEKc8glvVjsCuk/K7vK
	7tchiaKnesKwarjQoC896rHDgQwK4YJ26t3TKReUCgrpV7VOWs6ndDqxDhNLUrgZm6A7XsxL5R7
	nxDBIeLVRYVLCcPOFz+YW0yuC/Merxq1GxP89Sy5sqPtBRUwFfMWwbsHZaxV5jaovLveVLUYkAa
	SG/qO3WvNYm23GrYGyoUk0AarQIPLbI0Ak3rqdHSK7hdcSUC47RsTpDjaiR8kq+8oDndH92o5lL
	Ds+M42op0swtQXf3wsjULB67JkAGZHqlHzFZm3RJVjv1eLF3BuqDXvOY1ic/WDR4oHHalBTWW5T
	CI3FuZT9GG0ZYQsV4VzomU2b+X7MI0BU0u3IRgR/8jgYKUTt2q758M79HfmXvddSd9bhyx6X3XD
	/O7mD1k+/RhFn1QacCYkSirgVrUiWzANZp7EIVStxMh1Vd3hCUYtkE+uTUPvptlCVa08/WA+gSA
	B1ILyGGTxXvRNuTKVLGfFQrx2aBgWo11PE
X-Received: by 2002:a5d:59c9:0:b0:4ab:f5b0:a7fa with SMTP id ffacd0b85a97d-4abf5b0a975mr10806542f8f.33.1795249732684;
        Sat, 21 Nov 2026 00:28:52 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-aeb0-6801-ad74-bca0-dc5f-7242.310.pool.telefonica.de. [2a02:3100:aeb0:6801:ad74:bca0:dc5f:7242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb4341sm10892378f8f.4.2026.11.21.00.28.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 00:28:52 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: bpf@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next] selftests/bpf: Disable preemption around css_rstat_updated()
Date: Sat, 21 Nov 2026 09:28:43 +0100
Message-Id: <20261121082843.44614-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgroup_hierarchical_stats triggers a lockdep warning in
__css_rstat_updated() on PREEMPT_RT. The counter runs at the
cgroup_attach_task tracepoint under spin_lock_irqsave() on
trace_cgroup_path_lock. On PREEMPT_RT this leaves preemption and
interrupts enabled. On non-RT it masks interrupts, satisfying the
assertion.

Disable preemption around css_rstat_updated() so the updater can queue
the update without being preempted.

Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
Reported-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Closes: https://lore.kernel.org/r/20251119111402.153727-1-jiayuan.chen@linux.dev/
Link: https://lore.kernel.org/r/fmey2ektwdk7l5aktjz3xb24x3pk3lxy3gfld7reazal6xa6u2@tmryedehqhql/
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Assisted by an LLM.

Ran test_progs -t cgroup_hierarchical_stats on bpf-next 9867c61abbd4 in
x86-64 KVM guests with lockdep. The test passed on all eight boots.

  Boots with an rstat warning   Before   After
  PREEMPT_RT                       2/2     0/2
  PREEMPT (!RT)                    0/2     0/2

 tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
index 8fc38592a..d4babda81 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
@@ -6,6 +6,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -76,7 +77,9 @@ int BPF_PROG(counter, struct cgroup *dst_cgrp, const char *path,
 	else if (create_percpu_attach_counter(cg_id, 1))
 		return 0;
 
+	bpf_preempt_disable();
 	css_rstat_updated(&dst_cgrp->self, bpf_get_smp_processor_id());
+	bpf_preempt_enable();
 	return 0;
 }
 

base-commit: 9867c61abbd44f7053a871566b3d982f62c6d8dc
-- 
2.43.0

