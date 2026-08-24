Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3141E6D9
	for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576489; cv=none; b=XoC4CydhChzKloS7Jfi9MJqdVzSeuEolK2z//lH76/XMSDGsmLJh/Qtf07JfZ/deeuxHHWqPvJtkFXzG9GAWDeZTO+XSxrG3LM0pgly4dqTAAU6Vja8X/SfooS1iJ/bQpvOd/FPitI+qrcpNSPOXD4fSNQcpJSxYauv8KQD84ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576489; c=relaxed/simple;
	bh=ehxKGCl2X5B/1IOEDTS8ANSWyiXGlGGYkVM+GEl+HLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axwd3bmhxTh6y4G47itTmQlZ3KvrnNlLN44pAM5wD0gx/AxtdB4iawwi37deTS98txdv6+YPVhHI1Wpfb2IE5INV1h6K0byIOAOUlfdUTXaoaWwoe9yc6HcOszUvNYy6y+lGAKkg7a2/pGOaKM81LGibnJJZw/943+XQV+F4024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CX1XgLuQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CX1XgLuQ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c214321dc32so673752766b.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787576486; x=1788181286; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pt4qchYiVKMNGY6XXirkSLkRJOx81JgmCbFLO8XAS28=;
        b=CX1XgLuQ/BRF4FcNcY9qe34fP3qwP1V2sO/wzInDBMsraIX9vTfSZfCZflTOpths3w
         khLUKnTjfk/pTw2tn+0VXo3UIyhraqdx6nWEkMRgp1N1F+xnZMc8icmAZrX+SDIsGhdP
         eoI1mrSd36u2oIiU5MQZiShF86l04Eo/AULGrh1bWveGuv3XhnED9ilJyeZvLKDSVFoJ
         k5pEMf6ezfnzpWFxN8MZi6XkeFls7yWo4fmyQfGLOg0v7/IED6AP5kfFjywfWpcbYaZj
         sR8jxKbxraEQfW5cDIugi1PcEvsU56tbWYbDcRXq4MmIBocujQHd62gt1xR3hFlLeBBw
         boyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576486; x=1788181286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pt4qchYiVKMNGY6XXirkSLkRJOx81JgmCbFLO8XAS28=;
        b=hMEEdyWC3bGEbVf+QWQj2nscAI5c6fCDlpYh9Qnyl5Ys54WBwmDDlHySGKnvOVR4Bm
         fuoWtcbbeh6TIuDxaXsdrVi+Vvpm8z4j8JTHXUVLqOk0DEGixBkZIJp9aeihKU53EqxP
         9lUSmHxMpHXhGlrdZp8lzyiCyxTfr+gLbIeUHXa6pHMhHdUFdI+ZiVENUUJt83J6p9B9
         SkSA/nucsJGxhh3TzagYX8tM97MSJ7tydlrUElIwdMfQQSSvRREtCmzQv8XqABVHwb1G
         kfKyEYaCNRUhnXTA+CLTY4saRKetfalyyCzF2Z24fXY73z7cCLjzGhwx8u9+lf1UUBV5
         Yhlw==
X-Forwarded-Encrypted: i=1; AHgh+RppW6O9/ywgUPfvfuoAo1NWf7gZHXJ+fQtp3EqxVHigDvvg7fpkI3ZnoOSNBY6hZlQghxWafkOe6pw6vZc6ng==@lists.linux.dev
X-Gm-Message-State: AFuF++knTVbAwYAzoh/uQLJOWFqqijPAwNmHRYA1D5AX5a1WRZrojlKc
	g19Rr0tD9kbdApoQn9i2+N72Sc1paJvcCoTfT3/wwdUqrqyPN65MwAK4CK99D0NT8P0=
X-Gm-Gg: AR+sD12b/UFE/D5NANIgaHOYdIq0dlQ3rgzhUmnArC5IgF3teNFlwdhVnAYsUFW9NYh
	qA9tcZubh4CMQ5VbUFqVTAR1cgwEMhn1wv8XrBiofLGX8pSdEaqNIY4vSA/9tdhyI08dqzNqlwm
	2Zb80CzEzdwDQCdQzi/K7HJQ//rjin9nght2IR6CY8CyHOs55kfL/tj6//Iz93LHHgJUPcHcL/u
	FhUiSKPHnLr4yiU/5tTGXqoHXcuEol4bdGRWkC6JYpf9ar0v27du1x0i88D+2bGxNKsQUVTLHJi
	hDuDRrYWYLQmvfwjUtqyq/ZBRdArEkYW372oo5o9ZG9qM2O8VvIUBX9v4d0LjI30diawyNZJTjh
	ghMxsl/JfLePORW+qQZtMvRJ+w8Gaacf6frMk1fHbBF2PdiNuVltpxl0eJR14CEcfn70AlOn/Vj
	MY+lu6Yk13YKk3DcmojdeCOfm8Z+Q2GCGDRDdYlKt8oh3au6miLkuX5b8CF+QzoYEo5NgkpBMTN
	g==
X-Received: by 2002:a17:907:930a:b0:c1c:6f0d:5b22 with SMTP id a640c23a62f3a-c246a654342mr3127903466b.11.1787576485993;
        Mon, 24 Aug 2026 06:01:25 -0700 (PDT)
Received: from localhost (109-81-81-112.rct.o2.cz. [109.81.81.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249672becesm1294715466b.42.2026.08.24.06.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:01:25 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:01:23 +0200
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
Message-ID: <aoxAo6gDK00PeCzG@tiehlicka>
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev>
 <aow4YNCDa0gDwbfj@tiehlicka>
 <de12ff1b-2f7c-4efe-ba1f-95e0b8d259f2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de12ff1b-2f7c-4efe-ba1f-95e0b8d259f2@linux.dev>

On Mon 24-08-26 20:44:18, Jiayuan Chen wrote:
> 
> On 8/24/26 8:26 PM, Michal Hocko wrote:
> > On Fri 21-08-26 13:06:12, Jiayuan Chen wrote:
> > > bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
> > > conservative guess for BPF program context that is always false under
> > > PREEMPT_RT. So even a caller that really is sleepable gets the
> > > non-blocking allocator, which never reclaims and never engages the OOM
> > > machinery.
> > I thought one of the main motivations was reentrancy. As you cannot
> > really assume the context bpf_map_alloc_pages is called from there is an
> > extra care needed so that this doesn't re-enter the allocator from bpf
> > program called from allocator path and deadlock.
> 
> 
> Agreed, bpf_map_alloc_pages() is designed to be safe to run in any context.
> 
> The commit message should be precise.

How do you achive any level of safety for the _sleepable version? Vast
majority of the kernel is sleepable but that doesn't mean this is safe
from the mm reentrancy POV.

-- 
Michal Hocko
SUSE Labs
