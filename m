Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8973430CE5
	for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579734; cv=none; b=oNhDuKzGRC5/dRRe5HbpcqMTjHP91K6L2piaQDfxfLBxpFiE6JW+B8LzjZoJcPPeNubBP0Op7XqfcjHdTvCc/7cuQ656EJlIL39IL1lxcumkK45wJrU30AFqMzLh4rUshD1VtFC7r/k1EHIHfRC4ekCjQjmdrbptXfDMZuq6JBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579734; c=relaxed/simple;
	bh=AtV5dw9gRgzyoEMLu4aQ6z8qH/ZAjeT6K0W7X0N0QpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9aQ7wOZBmvrhDzBOfXnV/BHWD3uPXTZ6GEJ3Dd/PRF3gSM28IO3MKWG3DAv6eaeUfp4lj0o8i1IztUl1om5XOfZh56SNvLPkYarKL4VGTQ+iIr7MJP8ZVtKDIkU2uUFVSDAmeOhcgOMBbX1mpxr6trX/6x8sU0UqppyGlPMKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MUNJT84t; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MUNJT84t"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso5723539a12.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787579731; x=1788184531; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CTafZFi/HQ0yZlxsyK+vRPH1tJjqwxxSL7Z2p9md19o=;
        b=MUNJT84tGJCqauU9g8d32uNmNm4KXzVigrSDlVX73HOpq+vI9NXsMeuORMRNNn9Ayc
         me0yAl16Y40deqb8qsbIvdX0WLf7GT6c6MkeKXGIOLiihs3mj48j1UB1QSgapwLGbK7o
         MfOnBkuIYtIz/MlWHbSOMkieog3KpSDME6q4YpjDPuuOzdOlDbesU70D1BbeHEHOvcag
         G2y/7JG0LUlyNcp09MFhh/jta7ZIKT48BMxetebZ3L1wHS0jWLoNpuhXuTAEJVb40GIz
         E6J2T5Jx7mMIYoq0V7ZFiSaJWUIooTdstvIb9EzWUa+X8DxUdH5WG5jzI+ggBIc85i7o
         kgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579731; x=1788184531;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTafZFi/HQ0yZlxsyK+vRPH1tJjqwxxSL7Z2p9md19o=;
        b=oMYwnmpuaxeF+lNnmE2UfPhAgTcbkhcnUQ+y/ilfRcvq4vH13TMsPuMArJUl1JOk+Q
         i9ffIFQuuOMUZO3MJMufhudvJRF7JYUqRQsOvYmaj3PjQg6DRl6KJNaHb4H1uVkmXevi
         ihCAwRmPSDG2kwST7PK/YmPw7X95D7j0lKjmcOJzX3sYY7LFZGeTkifci9D/UDqeyk9N
         LjooEyPEvkQfWhAwtOHUHd/JFY8LCr84lTB0YjGrBDZ7JAMz+jxbZ0QiHyiW7M/bNoAE
         O9IltyJLHT0kOEq4fTpMfKrYFtklHL2QszB9R3u3zSEoDqpesZrlyf9uEnx0qeUKivF0
         CNUA==
X-Forwarded-Encrypted: i=1; AHgh+RqFbQ5TtwW+YztJhxhkvY0Olf8wzF4Qcl2iGN3BYJcNMeI7PU/xLlZ6R+t4Guve0/HDRkxf/7Znuzs83jffIQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kvt8V8nrpZkrFl/GRisqfY8u26KQg0O+dZCJ7UNZy4Xbmg7R5K
	5AKVu0r3Hlbpt8PIfCZsur6HxZ47I7TFkpwKOL4WMS1ISzrrYeXLDUB+V/D+PxV1nQQ=
X-Gm-Gg: AR+sD13bSRupjVYeilu5uVesFO9Q55z/CZqPbQhY89mtwjzFdqPhrtLkMvXyPMwN28Q
	aiworXOyXhFCklZ4xcXLvcgNRzQbm0XNHA8ajL9oxypYavgA/HBmepdi9zgWk8vQtZLLmG54Peg
	26NQqgv5TGNLgu6YO0InNM6z2OFVbFXJguyb3sccPfpz4BiZt8eCWzN605vQHKd3tq2YBbge6Er
	bMLW+xwZHiiO2bxaoW5Mqo/bf9s8T7TR7sfC7WreUs7ZM9QtsJh79C5IQtER83FkHIw0iUcLprN
	XgrII1FeP6RkGPYpgYJRceBQViobEFqxhbD2c7F70fhxSfzti5VoOhYdZ6y5qvptWaqMrpr8dHQ
	wipMD3p6j41pU7gR/iIfZ+GQbkio6D8TgOQ0qluWT8V9ZQo2ZqBWgxqMDGoRtck5MqOctyjfbKc
	KAGIzFuwyHeXyNfMlZkzJ0YrVVNGkqtxDT2w+IRaEe2KeEUvQZ1aJTU+egeNcKizOs9gOYwOfju
	A==
X-Received: by 2002:a05:6402:a5c3:20b0:6a4:e8e:9e26 with SMTP id 4fb4d7f45d1cf-6a42f1e08cdmr21176932a12.10.1787579731218;
        Mon, 24 Aug 2026 06:55:31 -0700 (PDT)
Received: from localhost (109-81-81-112.rct.o2.cz. [109.81.81.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199ad5sm8980194a12.18.2026.08.24.06.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:55:28 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:55:25 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add a sleepable page allocator for
 map memory
Message-ID: <aoxNTXWCCndiuewO@tiehlicka>
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev>
 <aow4YNCDa0gDwbfj@tiehlicka>
 <de12ff1b-2f7c-4efe-ba1f-95e0b8d259f2@linux.dev>
 <aoxAo6gDK00PeCzG@tiehlicka>
 <DKX77B18XF28.LG3DX8NUFQGI@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKX77B18XF28.LG3DX8NUFQGI@gmail.com>

On Mon 24-08-26 15:11:57, Kumar Kartikeya Dwivedi wrote:
> On Mon Aug 24, 2026 at 3:01 PM CEST, Michal Hocko wrote:
> > On Mon 24-08-26 20:44:18, Jiayuan Chen wrote:
> >>
> >> On 8/24/26 8:26 PM, Michal Hocko wrote:
> >> > On Fri 21-08-26 13:06:12, Jiayuan Chen wrote:
> >> > > bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
> >> > > conservative guess for BPF program context that is always false under
> >> > > PREEMPT_RT. So even a caller that really is sleepable gets the
> >> > > non-blocking allocator, which never reclaims and never engages the OOM
> >> > > machinery.
> >> > I thought one of the main motivations was reentrancy. As you cannot
> >> > really assume the context bpf_map_alloc_pages is called from there is an
> >> > extra care needed so that this doesn't re-enter the allocator from bpf
> >> > program called from allocator path and deadlock.
> >>
> >>
> >> Agreed, bpf_map_alloc_pages() is designed to be safe to run in any context.
> >>
> >> The commit message should be precise.
> >
> > How do you achive any level of safety for the _sleepable version? Vast
> > majority of the kernel is sleepable but that doesn't mean this is safe
> > from the mm reentrancy POV.
> 
> I think it will only be invoked directly in the arena map fault handler, which
> runs in task context. If an interrupt occurs and tries to allocate pages,
> can_alloc_pages() will return false and it should pick the _nolock() variant
> which is safe against reentrancy.

So you rely on callers to know what they are doing. If that is the case
and generally acceptable by the BPF community (no real saying from me
in that matter) then make sure all that is properly documented. Because
sleepable context is not merely enough.

-- 
Michal Hocko
SUSE Labs
