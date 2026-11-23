Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394838;
	b=2zvf2HPpAgB5ufVZWASxGSb7iu2W1mo5FlGq2OKTSc6IsVe8th+AJIfgOyN7R341gPam
	 ptr1RcqjTkF0BuoiEb9ex///7T6F65seLVmjRAE3LzCHlm2K8YpZ+obYA8HQb22FOnCCV
	 s+S0C2+HM1Pqpdtc/surMxWJEhUKnUYeFUA5rvzcusieD82uls3PHEpHpQPauSQTdkGR9
	 nhgxt+G3lUMA3kLOUC8jzan+rwTb6wjxFMcA/ppCeA2dvlz7niG+JKA5xq5Sz9tc8vBU3
	 cCax4G+NEahxLoeaJaM7o1HRSfX5299Sbw+6ij448Tgo2y7K5bhRzd2LiVxjOLZnHKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=p7B3c6D/X11fLUAKKmi13BRTcfCArxOmxqQgFnPzAxg=;
	b=fMiyBJLOFsEFzWGp4sJgBwFUAPcnLk/iCFwlnfwPW1JsVluMC7cY4Pf8yOTIGaJOJHA6
	 ABpmA0vXwbHrwxAW3MsvauK98N6qde8PoxhkmbY7RR/bXskVoKG0IaSyAmC2tBrZgXEnP
	 Gl6o32TrRxo0kDsmsRAhW3ws79osiq7+SRtREufnd1qwlonyccyuSpV6IuFBsRdLHyCvG
	 EF6xPYfS291gB30RP6oxF84toGVofTiN+PcPDnvLzvhbkKFgv2JQRo9TSEFcNsKgXR+SM
	 643GnY0vBj+O8X7gr9ToBJWq192sZqV5Wlq9mYNAmeMH4dGzUXEhSi1d0zhMFI8MPDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CqUzgxCe;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F802606A327
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 00:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F802606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CqUzgxCe
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb684859cbso1540360a12.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 22 Nov 2026 16:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795394837; x=1795999637; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p7B3c6D/X11fLUAKKmi13BRTcfCArxOmxqQgFnPzAxg=;
        b=CqUzgxCe0eNzc1f1wTiRq3pLJygort6nC0l5S7KxrITaazSCNsNq+iIgII/pGX+6gS
         0pwNQyCbpcqnHuzSuH9/4rGfWL6myM08JCy5Iv+K6ZmBREM/IEMPNJYKld3PwJ0HuDmx
         prv7RVwlhRc2nRMuPRI2wdU4hLjAsRC1tuP2gYPHBOpKGPxwW2802CfTfWIXCWPkz76t
         m6+9kHX2cDRao/6gtZ+0Ni626kkf/+L1FcuGrbtxbuSeeG6TKZnBylZz6GpVD9m5PDyI
         gh1YkAzrWephDlsiV9TbuQ1tN/wI2dD4s1ZqIYFNBh/puJQqpXh1NwWY2+dZ8E88Zikp
         nz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795394837; x=1795999637;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p7B3c6D/X11fLUAKKmi13BRTcfCArxOmxqQgFnPzAxg=;
        b=Eguj4H0B8We0WuW/gnIrf9kafOO0820hjSGZTKyqIyEruEw+krkqAum8MlfkuCAOWh
         15dKulsfUfpuiD/plbUntTBO2iTJjLDsl3au6XbvvgPSgSp+N8O7/tk2sdEtPngqjfvd
         tlZU4WqJ51MU/YAxrwxNz4HlrLxmIi04mgi/1GRNKR5CzLYoRY/K0jTB++U4WlZOr6eE
         hSVdyWiX3N5MALBcR91RdG3vNfvrn+Q9CHmrjroPLYcBdz2bceE4Am+uPzdrTl1rzSyb
         NB/CR8lBXVe+xbQ/bvwWmK0eUZHLmG8KkqrIRsTJDGWnOAUiI4GrwooxdUs55iyfjQhU
         HofQ==
X-Forwarded-Encrypted: i=1; AL+hErG5emDDZ+pYBAWMXZhAHJAiw42JLm7P5sAdOJ4YOVi1yEtjt1YkfYjevWRRY1AKvIjgyqGxu51etDUUy7e11A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8BwSSpipRk/z6nG041kfEs802bZZyipaG0UfUl9VvW5u5PH/j+
	5QfZvPXHKBrWT4tuVG3nzW3gjYrB9Ce/JF4hEmi7HxxOmJEHxtfN9TC4
X-Gm-Gg: AZFdTZcE8VnojOIie3G9EL9FGhyZldwHykdfR6LHnNTHWl/CVb0JZx4/bL0IxwHEwmp
	7y2v+hJvQ/dulVg81VrNZm5UeBfOaYEgBjTmcq8MCpYjrpWM3aaX4XG1iZEfF5X5MZq0553KXQW
	WDgwZbTmmeKTapozTUtN7fbeTcsamDEpJ8kEqzMlVOfYcC1Ll5r+4PfKRyBBQuZvvvJ+gO6o82a
	zeMrLfb3LbIxIG1zW5/3YETBCDdrRItX6od2+lFrZqSlq4nWUszzAE1qFmXQQkVpkktKAia0xay
	5tSY217AOOlfrKPE7VruKtA8qFCME1sp+1d0U6opHZGgZ9hjDHhKlJSh0QpNKj3KkQMUwO7xN8Z
	ui/eUYpJfquN1Pl4bgTb9v+QuMtRb1pLB6e/l62Y5xS3GHZoEb67DJjHgNvdyih4O0kOGkxteNb
	5XB0xwkQdzZ7PW262WFWIjNdLTHaEi4dSgp5vlrtYqma/VGGJMmqtLIrRGP3lcIZrmXjI8CZYpJ
	E5U84tlr58RJSs6+1nnFuhenv5Zby3n6lAs0e6Nem7Xembbe5ZnM5VbmBH+cLZMGbzJxU0WGG/q
	ECuWuyFFKjd7lD4YixaHHc37YE9iguxZ6YkUTBglCeS71kGj/xqCy7blCT2uLfL5Ug2c2F3Q3k6
	VM32dKXB8YJHTp6u9obPu8KuGf/FZyl3l1A==
X-Received: by 2002:a17:90b:288e:b0:3b3:ec88:72a6 with SMTP id 98e67ed59e1d1-3b41c85284amr8792429a91.3.1795394836739;
        Sun, 22 Nov 2026 16:47:16 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm15471631a91.1.2026.11.22.16.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:47:16 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:47:15 +0000
Message-Id: <DN26CP5BB6O7.23ALW6CZUBYSD@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Karl Mehltretter" <kmehltretter@gmail.com>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Waiman Long" <longman@redhat.com>, "Jiayuan
 Chen" <jiayuan.chen@linux.dev>, "Puranjay Mohan" <puranjay@kernel.org>,
 <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH bpf-next] selftests/bpf: Disable preemption around
 css_rstat_updated()
In-Reply-To: <20261121082843.44614-1-kmehltretter@gmail.com>
References: <20261121082843.44614-1-kmehltretter@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Sat, Nov 21, 2026 at 12:28 AM Karl Mehltretter <kmehltretter@gmail.com> wrote:
> trace_cgroup_path_lock. On PREEMPT_RT this leaves preemption and
> interrupts enabled. On non-RT it masks interrupts, satisfying the
> assertion.

let's fix the kfunc instead

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index de816a4..d72fe72 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -131,6 +131,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (unlikely(cpu < 0 || cpu >= nr_cpu_ids || !cpu_possible(cpu)))
 		return;
 
+	guard(preempt)();
 	__css_rstat_updated(css, cpu);
 }
 

pw-bot: cr
