Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837685;
	b=kjw2NdNj55eXOta9ovVS1gN4K3o69ssRYvlQ8LRL4N0hSSBRrVT/OBLAnhwGxXpDLPuu
	 KywVdKR1nsRmm+7P5pTTAbAoEsWgzrAtIJ+B8B7nwr/myaTlPA13xGqiKOroBifolY2pB
	 riCHSqVwoKR62zO/+4NkCw1WJ0i5SV7jtScbMmNGEPcYanKJb+CdqjqlIj1eGhkq3V+AF
	 YbmE7kXmkuc6uAG1Lupy4eQKjSL3w+duC4cIWzaCK5O2mJsinNwRvXODGRhQUeGH+pqn9
	 fYZ+lBDKIjbQ+2ynHYszz4tWW3iBn6Z3sUyHhNPKaOpjVtnj7LBDQLuu5n4faM7ZHpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Zw9evio7WIEnyHMe5y/JwH40NK3MTc6qnKbAntWHX5w=;
	b=PsUAiAIaWQPhHEa0y6gvn7KFE3k/17Kp7u1d+xP3RrD7mj37MB7bQ52lLsS/6Uj4Hq2w
	 oQ2nXguqknFgwtF2b+2pPkG3Md9uEHZOezZs3Q9yB9A7sJ5Exw0nM1CiupbnFXly2BTLg
	 uRfO8foF99gf0lY14Gjo3CCnCfJRrTTQJUGR32YOL4oJM12BCe0qG3neSH1c6wRT7WkgC
	 Xr2Gers3K87htO4l3KZmgf/x7bLUbrMdRWay85oSSGsMbW1T/dC6N95jW/AyYg7MofdsT
	 AOvgxoPqOXELFeZVKHCb+PoxC7B4A4jQ3I4P5n0z1VSyFhK0OoeXUQ+jp8NXSl+5Abw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="JSnM/rkj";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79638606A31D
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 10:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79638606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JSnM/rkj
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e20edd106so1372897f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792837684; x=1793442484; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zw9evio7WIEnyHMe5y/JwH40NK3MTc6qnKbAntWHX5w=;
        b=JSnM/rkjmObauhQYVBBFD7PkKf99Asi5Ihz9vp4o9/NnNUvpv4th7YyhHB8YUblR07
         NhvAF/oos68z/e6voK0/xUvGK7UMPXy0BBazS99Gk1ghzNj3O8rQyaWcDJaWxHvv5o1M
         yNyoqubf1bF5nMZPKJolVhfoglHXMaS5oSTzN3g/K7SXEUA7j2CFB/xK0Pyv5i7rmajk
         5pC8qsCUxigy8vN7tAvPCZdPjkvEQyK+CwgSG3sr3geyTCHXa2pEmQ08hCcRiHI+eLdF
         ekK/6JgWhqOLS/jdo+LqzjM563UpJQIXNKE5BWywu7xqfHC+hOcnRz5Mzw14mfS0iqLA
         kFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792837684; x=1793442484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zw9evio7WIEnyHMe5y/JwH40NK3MTc6qnKbAntWHX5w=;
        b=cY2mBiJUB3gVZBVKSK4pakLRyfEth+q1x00KLvwNxgHw33FlSo7XsnWX/FhOrD+hTI
         tgLghW0lCmq4LWxPemx8LH4P9IPFKDDdshitXLW3hg9gSBPxgxW7yEw5fnaZw048tiI0
         ZwH6Z0e2lorCFZfnlrtiERTgYtBo/Rfb7+hKh8vZ2DtULlbnA4pQgvKdxRbvH5iTyvk0
         Fjzt/J+qfav+OMgekSvILm0ik89XREB2YvE4L/KeYLJzCuABihOg2f4ygh1oOdFmnhoU
         pnFLDF/6c9ZVoGo2Han9m0pvGS20WP83YseXbvgo06SBskpUFHu27sQ7xXrw0BReRKdm
         qktg==
X-Forwarded-Encrypted: i=1; AKwUvBy/dRd1UmXu6dEtKVewDOvOhlQvIA+vU9w/KU4iyGe+KU3FpiBvBM4G0yf/EOWmHMNE1pjt9uPI2+Eh0ryVjQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJL7AIlyLwxY6Ix0vXsSbdyAdzSSGwnOelpiAjhGc2R7jem04+Y
	dVi4RFuvah4RHjlFm8R/LiKALKBHN1wbM07qu/pi6+1NhcJBoRA5pmmL
X-Gm-Gg: AYBFou14yNcFCa7tRx4rWvelSTwqgqFq1CHD4aAFmVpcd/QEkU51loEUeQI4D2yFXJW
	RER69+xzAA8eAcGrW4Nt/WTGQ+VASrWHvQ8lD239U6gTN0G6Qy5JuCP85ZsClF9t1trmLX8iiah
	hrJ2SrcYGZ7F/DsDjjppzMDlax6AbT8fOZMWvkkDSqzV1RJfQ9yaj711Ko+rub81Ho1KuBsizPO
	1ADUs12AikMI9Sufyln86dYr09PQXeM/URwamhAjErsRt9/DnsK9Q7JKNuLwabJ3v8/y9RAT31g
	xGI7sL8X/w5D0ojlOzOSejyQknZZ8JsHujI3fGG68vzIAPjZLTRXz1GaTWYmr1DNHihLOKALY8z
	0AdqoX5RpdmaSdWtsQ4Uv3j8Jva/HbScZ7mWOxL0xFrjJJECkezVMzEKoHeJL1kNcIU+b6TyesF
	bD25YzKkimMPyJ3cuDW/xQbROSHL4rqcIXkTYDVvcBPBw4YhCeTxyAtq1MMiZA0SbVur+OsBRrq
	4KbgK6AN6aTIG5Hp8U1qwDryBu1ULQ9DDjh2onodS4Ub4vu7rXFhIbT16W7mGF1iXILivdg9UD1
	NVfhFeMrKqNWPnxXYhi6hUCioMIFSJoDntIg/0Hh3qLCcbIt0CRtVWjDyPTN6wI/jB/wYLLa9vg
	T+bo4SJ7BWTXa66S3ksgplNnoD6Dyq3UPBfCpFdC9AuOa19WAkXoMUBQ4
X-Received: by 2002:a5d:5d10:0:b0:48d:e62f:db70 with SMTP id ffacd0b85a97d-48e3eb9c239mr2514461f8f.48.1792837683543;
        Sat, 24 Oct 2026 03:28:03 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9da9-5f01-d5f0-7ecf-afa4-4bc6.310.pool.telefonica.de. [2a02:3100:9da9:5f01:d5f0:7ecf:afa4:4bc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3a1csm3506285f8f.16.2026.10.24.03.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:28:02 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:27:59 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-trace-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] rv: Verify generic IRQ context transitions
Message-ID: <atyGqz5lcvYQvCYp@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
 <5b3ff014bf2f571b935f9519f422966a1c665c32.camel@redhat.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3ff014bf2f571b935f9519f422966a1c665c32.camel@redhat.com>

On Fri, Oct 23, 2026 at 06:05:30PM +0100, Gabriele Monaco wrote:
> On Thu, 2026-10-22 at 07:07 +0200, Karl Mehltretter wrote:
> > This RFC adds events at the generic hardirq and serving-softirq
> > boundaries. The irqstate RV monitor checks their order and agreement with
> > live kernel state. irqexit follows the owner of a preempt_schedule_irq()
> > invocation across task switches and CPU migration.
> > 

> 
> Hi Karl,
> 
> thanks for your contribution!
> I'm probably not going to have much time to look at this soon as I have a few
> holidays planned and other series to review first. But it looks interesting.
> 
> What points my eyes is that you didn't include any schematic graph in the
> documentation.
> Some folks don't like RST, but I find having a textual representation of the
> model there easy to understand what you're trying to do without having to build
> the models.
> We use graph-easy for that (and adapt things if the model is too complex).
> 
> Do not send a V2 just for this, but please keep that in mind for next time.
> 

Hi Gabriele,

thanks for the encouragment! Yes I continue working on this RFC and use
it to check for my related early irq cleanup series. I will use your doc
suggestion.

I will wait for further input and liekly post a v2 in a week or two.

Any broad strategic direction for me and my LLM are always welcome.

Regards,
Karl
