Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444382;
	b=AwIlo/JvTYR9rqRglBH8N26iKwdcCyCl1lsniyjr2bvjauj0RkhegPI9hoc7Mdo7KUU5
	 ncNyobAexTJLeBvPSQKuJQSgh9sfpAqOb4g5Wwj5L3/ObRWiSwo/F5c+N0vGkqrQKQt/e
	 /1BIQmFKOvNUwDucWmymIxIhWuEYQHOvBth5G2IYnXL1o7Rm2UBp/B+n+GUkkwRWjlufb
	 edEEulfEOdzLvpWqFKX/OmtRIHpsF3YsZ66H9yVX+jnwHYqq8SYJ4i6y9+Md5GhzF9rYx
	 WdM+ltuem7jUPbskMm6fcsNEU9QcvTaciapaQTKwy/lT4JqI3WmawjGwXw4xZNZ38DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444382;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=k633DNog7kHsc3DkibIR1k/YpXw7SywtAhFVDY+BYIk=;
	b=nXPqdlj8kbbnkOzgTBDANnFFm9Zt2GtCVUyKQYg0gQ/QCpuEUEEULw3o6sHcR3xwXfUC
	 GdxXbZhkjjfUo9dvy/AwoeE8MmfAdcEXx78YDsXJHtoqrciU6ffjewJh+fWXlbZeyT5TL
	 T/LlMkXZbaNXpw7UybHHhMKxWD1gs+zpo1llij+wlAG+2X9xaDCTUt1CCTBUuvQm5fEaL
	 8gH/4RO7zosKIzh6atAUxlKX6cFb0GGmt5XbUp+6CBLyr8GO6/RD3VI++QmSXpWaAN4bZ
	 8Ums+bvH3tmXlSw2BkP3tiQquoNceI9BmOnzmxyTNJTnN1CCi7zM+GF2RhaQ8GD5qjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZxtcbYaU;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9m7Ugj8n;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC6606A31E
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 14:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68AC6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZxtcbYaU;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9m7Ugj8n
Date: Mon, 23 Nov 2026 15:32:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795444380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k633DNog7kHsc3DkibIR1k/YpXw7SywtAhFVDY+BYIk=;
	b=ZxtcbYaUCdJCiwN819LIpdx/24DZbqjBfdQLHv34aaGA3g6B99AUapDeSMVBiZcLKI3T/3
	zvh2H+xflYd9shEF1DUmaoB4pE9tq4NHxRLw1TL+3pyq4dAwkQOodC3IJ9pcaVfam/nZ3b
	0qRLEUc4B/bPPfvHx9jaW4JMKc0izaPU7RPEumvkTfxbIK9k9jscgM/Bjex0Z9Ek5LfhFW
	454ibkUJW/nJ5A6c7mDBnQmuH7fMxghGAi5sWAAPImLLNK5rzrSGiEKP2/GZjuuX/ryNKS
	+49/kTIbVt0lPKuGZKVyLVapuH4rqCR+iXqoePOK0d9F8hnQ5Ma/c4nuOtY++Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795444380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k633DNog7kHsc3DkibIR1k/YpXw7SywtAhFVDY+BYIk=;
	b=9m7Ugj8nI5t0iqfjMRoRoinvgwt82fY/F0wRU3yw60HfzxIXFwcVx1R9IMTqDI5BsG8Ath
	nAsai9NTuok7EuCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf-next] selftests/bpf: Disable preemption around
 css_rstat_updated()
Message-ID: <20261123143258.N1ETiMUU@linutronix.de>
References: <20261121082843.44614-1-kmehltretter@gmail.com>
 <DN26CP5BB6O7.23ALW6CZUBYSD@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DN26CP5BB6O7.23ALW6CZUBYSD@gmail.com>

On 2026-11-23 00:47:15 [+0000], Alexei Starovoitov wrote:
> On Sat, Nov 21, 2026 at 12:28 AM Karl Mehltretter <kmehltretter@gmail.com> wrote:
> > trace_cgroup_path_lock. On PREEMPT_RT this leaves preemption and
> > interrupts enabled. On non-RT it masks interrupts, satisfying the
> > assertion.
> 
> let's fix the kfunc instead
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index de816a4..d72fe72 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -131,6 +131,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
>  	if (unlikely(cpu < 0 || cpu >= nr_cpu_ids || !cpu_possible(cpu)))
>  		return;
>  
> +	guard(preempt)();
>  	__css_rstat_updated(css, cpu);

This looks like the only call site which did not disable preemption on
its own (the other are either NMI or have get_cpu()).

>  }

Sebastian
