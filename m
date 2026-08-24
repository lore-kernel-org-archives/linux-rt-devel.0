Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197E40FDAD
	for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574373; cv=none; b=lNN7TSUgdO0qX9czQ7h7iej93v+FcAoOD+pefK33V/QoH1F5Vc9uU6tnmhb6gYyYsXQAYXkN2S9tDcI0eV9O1JKSkSAEOLhGw4YAKUt7AHnPtfALvMpsbP5XR0owHfUuYpMGUqq70UhROZqdkxCDf0aHS3ZSdpL7+5NVipAKU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574373; c=relaxed/simple;
	bh=/+ibtZfVhOlusR6XfSWvFqs9qwlfi4JTFLX1PAuC/Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjE7MnL35WHdjs3azo0oLvFh4a7YWIaOkED8MXvCDXy6r4oFMafZD8i+yv5p615mC9e8TuZ5DmE+X69wv35BnKqA2bUFegERyY7gtNDDc3CP1D35BBGy0HZV6T3k/NUeAyL2FGvS1rJfvV/EozLbXJvgU72Urna9y/+qk7I3A2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=clJPvlGV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="clJPvlGV"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so382365866b.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787574370; x=1788179170; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HiNLXqPQtkSfd0I+8Qv+U8OwvNuLKuIdd4i+Pk8Ei5M=;
        b=clJPvlGV91ylDuj60mvwXWAa3bpUNgJ3Ih+bzUlStR6YC3Gfli70Kv9j0gSF8Tc+/X
         k28UQItnvdC6vKAUyq26bZymoB5kHhOe+sLhTIVnVHtf2SpdNt0RyrIhliOroUJifQ/j
         jCCWJZF6vEqNokYnwR+bVFg5WR/GzFnBynQYRing9TttY3a98yF1LG+csFqiFXPFJlJl
         yniRsAy2I7Dmn0sMaBtOERVaJNTthUcUaVGNNbmvfyeykkuSxJHNTItoG2nP+44pZsmd
         PUYn6VKWn2pE5m9FBGL1JxbOGgIO45d4IFcxshuP8sm+ZI7jMIUz7slollCXoruPkpmn
         2fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574370; x=1788179170;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HiNLXqPQtkSfd0I+8Qv+U8OwvNuLKuIdd4i+Pk8Ei5M=;
        b=Ijq0d3OKjV3R10dwiuL/LIqeFnDF9lT38w61XEOLNXTsHYAjWFzNjq0SmvatGfF9PP
         YfPl2dCscqYt6xPoOEL0vlc7/BwRq0TEbrttYrdcMO2R7z6CKrsrT7DPW83fsjfL1C4p
         N5QgYLeYsmprG7E1J/Dnd5uKkXU7Rf9Htm6QDA1jjh5eDfxShToys2PLAXTfjj/AxmZ4
         9EJho/wEQSoco2tv6Xnv2ZuXOvQeENsdXPJlb2ApONOnHlssg0kK5u2Jf2CyDSXEKQEE
         VI8euctIWq86JLgksQGFBweeFDqzs8qDjboRG8YIESeN01oc+4xLQ3pGTY6d58EvWhRb
         hZYw==
X-Forwarded-Encrypted: i=1; AHgh+RoCSfoBsA7N5ej1BskoVgsspNfMKNwXIR4lPa71eW8izT3Z4nXtbfAXSMlEHDMR7ByoES8jcYNT7C2i49WRIg==@lists.linux.dev
X-Gm-Message-State: AFuF++lWC5d18DZ/QHrkDxGo/EtaecOU+2XmMaW+WLEhlcWiyGRXeD0w
	e0qxKKRjNkp2sWQ5xvEpAA3dxMIi6fy1PsdbSxSmbm7qPZcwaTgqz3A+pWDHbEvcpAo=
X-Gm-Gg: AR+sD13w4g89S9yIC2wOD8hWQDERM8ghB7RFtGVumjAJ+TPaF6jEip03VC9oIytFPl7
	qEtwXAdcSWkF53g6kgTF+RvDtbA6KItt0HTnvoxQleenYR3QwfujMA44GO6MrC96JTkGCCtT6J1
	zD26nLah5Ui9oTRtzU1Q7I4/+mj1trxuwGBIUOcB804f0y/FGUpyNJAaDQXIJKMPEgVXVSixWkX
	LdYqAex6VrGO2Q/VhFP0rU++x2a3eu8uVtBP6AqmX0RilaM6hcmSo+/JHnWMlLZCDCGoVTmJZ2V
	RwmZsYs2Bgf5QGEEnSoIeQ1m2lXqdNSpZD9bwftNRB9C4hL613/cotiNNUQRAIxwO3LFOCkxYuj
	ZQYfCaHdoqgRQs1cNcfOqjT/zsPfzyWMGYid6F2JUfw5hS+XGN/ERbkvYJWTSxvGyj650bjX0Fo
	QiRs9AnHVwQZiDCJfSUDPAp/DfEpvtZxRrBDzzQpSszUCcoxvBES4efMD4L8PO28iYQf+H3hvg1
	Q==
X-Received: by 2002:a17:907:d12:b0:c15:f26a:3438 with SMTP id a640c23a62f3a-c246a6b0994mr3185124066b.24.1787574370353;
        Mon, 24 Aug 2026 05:26:10 -0700 (PDT)
Received: from localhost (109-81-81-112.rct.o2.cz. [109.81.81.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24d8375776sm177761566b.31.2026.08.24.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:26:10 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:26:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
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
Message-ID: <aow4YNCDa0gDwbfj@tiehlicka>
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821050631.39784-1-jiayuan.chen@linux.dev>

On Fri 21-08-26 13:06:12, Jiayuan Chen wrote:
> bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
> conservative guess for BPF program context that is always false under
> PREEMPT_RT. So even a caller that really is sleepable gets the
> non-blocking allocator, which never reclaims and never engages the OOM
> machinery.

I thought one of the main motivations was reentrancy. As you cannot
really assume the context bpf_map_alloc_pages is called from there is an
extra care needed so that this doesn't re-enter the allocator from bpf
program called from allocator path and deadlock.

-- 
Michal Hocko
SUSE Labs
