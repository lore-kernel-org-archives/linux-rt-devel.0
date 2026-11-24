Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490215;
	b=Yss1vSVdLELEVZoq7TxsA5ZuludA3wmFIhH8/Bs4vUzI6gSUwpP50pCD6zAEGU0rIpLw
	 rDyNC5RL8/d5CeKda0NTvf/j/aulCZxVNs21ka4iLOP09tVwwcSWWSex7oKfX7vqXqkhe
	 hu4H5Gu6RMv4EX5gDtvdRACzfNRdIJbBQLeHUReOPGpLrcpu1qkS8ajjsrmv/ajpM4pZq
	 qnMU+YMmgGDN8mJ89qRwxCBy7Yd3pDUnoXfFuAMFF7QgIoy+iLpKjmbYLdpyqC4vO/sKy
	 bUWz6dgnYLq+0QhqHTKRwAkbAB54ZGHiLG0rOQSe+sjdAaAQur0VEMqrFwFHpofE/gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EKCwUBMZXEgwJsoK8+iw5jP9TfBZ6zy/Sv767cpvROI=;
	b=CuAu8SeCHWWvxJIqZCRJHqo2ysa8qjY3dT00QEr+MVGufVAIJ9MjzHst7gzAmsrgBPqK
	 3FgWTFcgvv0VRUoTUxsr6XHvrzZ9W+85F/R4ds4/q+dABHtVgv4ekq12u9TensK6Q+kEi
	 HLK2lhtv37LNDYXIQbEEChUUFQJC1Ik5ZG11MMIPEbWV5MsO0JZG+S0I3giYbo31FLHJL
	 4I3rUcETlMFBDOk579xTxZCCdSM20czuwTCcDynSKSyACSxPyYoupk03O/wlJXihvu2+7
	 p+bMsqRcQ9WKWYoARdYPqhOp6q2sN+bX/j0E2jFl2tWLCCm1xysQ/+dlfwyoIrtcRYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CK+kKXA/";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC600606A326
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 03:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC600606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CK+kKXA/
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so33832265e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 19:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490213; x=1796095013; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKCwUBMZXEgwJsoK8+iw5jP9TfBZ6zy/Sv767cpvROI=;
        b=CK+kKXA/iifgJqScTA1cDOTXqeBMGcPB/yKIrUNH0UUkhi5MggdOwZMFqe2LlQZp7w
         INjAriviqd/m/1Mqx495cCY0rG6opW/8cTbqjc1ET4zHulUNb1ApA3YWFeI8DG1kcw3C
         OG9AQiMR3fkVnMjTlC43VSUiCD+HZRy/EnGIksHDZwj+pPs1owSVPTGCat5jFNFdt/8l
         kpRPapiPreZYvS34Uk6qmhbrFLd5bK8KK5SSVU9aItYBWhFh6zltiCq2mz9nWy8Z3v6Q
         oDr0prDMujxvCA0Yw4gp88jA72A/+5ijRQUGqIU8EP/E5WeTM6zBF3JOU/7Ul8DXMHsO
         6gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490213; x=1796095013;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EKCwUBMZXEgwJsoK8+iw5jP9TfBZ6zy/Sv767cpvROI=;
        b=eFXbEfg/0fByiZit+K2gsxvZYmi+OQCR5371sinZwAgB622avVwr6a05VBhVPM/fBN
         Cw5HGpVNMkJVQfLyQSodI7OO5P9l6NjWzD3Gj+4FGhPxuFQyl3UURCXQ3cLuU+pKH/Td
         RPr0TwW+u8iKz8XNbKJSgKablFFEf1cu6GfwKnW4pzwvtWhUc4XFtuDEOUqVQEIvJGGv
         h6frfp0cfys/WpoZdLvwecazwg1+XMzsgTkZdoRFgLIF2zR0fZj2BmabNf3DsBQHNeZM
         fJKjRhLOCMEoAlZnFF3ZbKPih+Xtp6ajArQojSV+RrjqiM5PulTviIN9SzmGuRnkKI1D
         MQVA==
X-Forwarded-Encrypted: i=1; AL+hErEl3BM7ePvWQAU8GQd+7fHI6dZvT54T0v5A+UAGOPvLE1e8XqpNr9OqEj01yVMTFk1BEUFw/lObWSFCYFjhtw==@lists.linux.dev
X-Gm-Message-State: APuU4Z87F8ebbjOjke/LyG/Qn/uBEpOO4ubNGk+tkY/eJ+qvWKdvyXGm
	lxlNwgfNziGsIlO4YLtP6xBlESRKVMW11C/jOvOm/z7GIdtYNSw/yWll
X-Gm-Gg: AZFdTZeq7s/GRIzmD7m3WjPzFQNJdmEdSpl/7gGu5HI8xG+xacjRK/0EUrXOsdP+djb
	T7mOh284JH0IhNCFF4Dxecmj+MzXbeE2eDiCJmWikCXif9b+DrMb+/vcNXyf1kMlJISSAB1VP5u
	wXL2Fjq1HbHsBE1QKnz4uwvYp4d89wy+wf3ugPcn2TABAALi67cZrJ6rhYvUsDKEklTjNKsiSt+
	NJh5fD5UKbMq1IbfvFI4F+sI1g/vMbNCAZNNtDHbHKGNa0argUJWPJYgl5b7npZkIGjRfjayQvt
	5j7bnkm6aXDQHw67SSqULTPJ6wznxOqBsimFJt1pVGdKw98JE92wejGmo6D0az114oPdwAqmWE9
	qISrsjaDk7EbZbeCZtoxJ3NbgTFn0icG67y9an0lpB9mkdfavR+XTovXMDRMdunCW5NykdmyGJi
	CM+TU6OOiqY8glV79Rnrdab92aX0/l0LmA/hS0bZCf0z3e0gCnv2x7a8J6zbLiTuEeGLj76IpdJ
	QqbD3AlmSsZ2oqwY9OVc3BI7Cc/V815ft4r7m9crXwOgivXdz9GXGkmR87Ufm9Vai+82Q7QxDpO
	WFdHlf+F4KpDQh0jljmzCr7MiSDaNG5ybIt4ncq64PcayUTzPnZ8XrNi+n1PWC+oKk9ROpSzNs3
	Cf5ltdP7YFRjH+/s3SrXbV+zEeTi+rHQJiVCK0E/v/8xuzokhtAesEDs2/+Cruu+kDAD23xTBkB
	5c86ox9vcU2XRELfONomJMqCcSTc4yBQsG
X-Received: by 2002:a05:600c:1389:b0:4bb:6519:477e with SMTP id 5b1f17b1804b1-4bb88813b35mr273527695e9.17.1795490212815;
        Mon, 23 Nov 2026 19:16:52 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-ad33-0d01-f099-1558-bc26-fd06.310.pool.telefonica.de. [2a02:3100:ad33:d01:f099:1558:bc26:fd06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm473350865e9.6.2026.11.23.19.16.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 19:16:52 -0800 (PST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v2] cgroup/rstat: disable preemption in css_rstat_updated()
Date: Tue, 24 Nov 2026 04:16:42 +0100
Message-Id: <20261124031642.40616-1-kmehltretter@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BPF programs can call css_rstat_updated() with preemption enabled.
The kfunc calls __css_rstat_updated(), which requires preemption to
be disabled while it queues an rstat update. A cgroup iterator can
hit the lockdep assertion on both RT and non-RT kernels. The
cgroup_hierarchical_stats selftest can also hit it on PREEMPT_RT:
spin_lock_irqsave() on trace_cgroup_path_lock leaves preemption and
interrupts enabled there.

Disable preemption in the BPF wrapper after validating the CPU and
before calling __css_rstat_updated().

Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
Reported-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Closes: https://lore.kernel.org/r/20251119111402.153727-1-jiayuan.chen@linux.dev/
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Assisted by an LLM.

v2 places the preemption guard in the kfunc as Alexei requested:
https://lore.kernel.org/r/DN26CP5BB6O7.23ALW6CZUBYSD@gmail.com/
Since 8817005efbdf split out the BPF-only wrapper, v2 does not add
preemption operations to the in-kernel callers discussed when Jiayuan
proposed the earlier kernel-side version in November 2025:
https://lore.kernel.org/r/20251121040655.89584-1-jiayuan.chen@linux.dev/
v1: https://lore.kernel.org/r/20261121082843.44614-1-kmehltretter@gmail.com/

Tested in x86-64 KVM guests with lockdep on bpf-next 9867c61abbd4
(base and v2) and 2bf3351c5f89 (v2). Both tests passed on all 24 boots.

  Boots with an rstat warning               base     v2   rebased v2
  PREEMPT_RT, cgroup_hierarchical_stats      2/2    0/2          0/2
  PREEMPT_RT, iter/cgroup                    2/2    0/2          0/2
  PREEMPT (!RT), cgroup_hierarchical_stats   0/2    0/2          0/2
  PREEMPT (!RT), iter/cgroup                 2/2    0/2          0/2

 kernel/cgroup/rstat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index de816a43db9f..d72fe721cea0 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -131,6 +131,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (unlikely(cpu < 0 || cpu >= nr_cpu_ids || !cpu_possible(cpu)))
 		return;
 
+	guard(preempt)();
 	__css_rstat_updated(css, cpu);
 }
 

base-commit: 2bf3351c5f894697e8443eeef5333d4c4ce90cab
