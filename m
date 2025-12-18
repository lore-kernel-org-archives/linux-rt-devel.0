Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1369432E14F
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060250; cv=none; b=GBBytVwm35ruP1En1hDnwzH7URbkG0HA0/4GjaGq1dkcGPnTlHwoWFmQmixzt6m4B/IJDjuC9GS4cXfnSe6ll4bM4HdhBGYaZ3OIpLUCpTgSygTUd820OU0rcDOhP5Upvah3aA8bsuLy+xvDvQ5t47l0n8vxdrYQsgiXi3gvO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060250; c=relaxed/simple;
	bh=TK3q9Qn/Pe4y7lyna7D732vtlt/WgAJ3OxwB0ciLL7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI5vJDWGDRAQNpvpn1Icyx8ZLeo1RsUePbAYjhjrpfSUDwiVjDUEw7obUF+3oo/RgXsHWgRsIL3AxHqjP3Vszw1qqYwXZlM+tHG3UO/+K6dW8DcqRupgmeBbadTni/eKuOQowmfSKM4QCl+IcT79kpqa4Ql0oNu2io+ohXtt5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FkmMiHP/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FkmMiHP/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso4354685e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 04:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766060246; x=1766665046; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82ryBTb0OYajbtmHnpP2vY6hULmAqRanYTWCsyHvjaM=;
        b=FkmMiHP/1/vHqU75mCD4vtHtgtz02YuQfruyhu/lfYn0LZpVkiY5+BSPWNAHZ/NKsO
         jw0oJaEKqjjsvrF9bNchr+B28un7d963wUn85YapyXmQk1gWZPjaxnRHHPvvxY1tgLYJ
         MrOJfge9KZiONr4pMfa3TlgZG/vQkzqPovb4022UBMXFwh832VezopptfzUzXfYATQ66
         EOyx/3Zrv1kgAuCFtV++yWtLUEVzFELvbmaIZIzQoJIIW8uC1NoO6pRwpljyQ1Hh1v5G
         Gj4PVg9TTRWSPyI8eIFkJMcCXxKU7TpAtcgK2jCDPG8EnPAf79g8V1tr1FmIfVsPH+wp
         KJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060246; x=1766665046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82ryBTb0OYajbtmHnpP2vY6hULmAqRanYTWCsyHvjaM=;
        b=CIXUgpCNEgKIC90ozPJiXcY1hLgu7YazwNoyzhuSPTsD6E7nVNoTGpIYJcZAPtPVCO
         cJjGcInLk6Ny1FX6c+BDjJyJ1I4Jn4RfBZrhwTpgSfOp3XKuEwQvqJVpKiTVl2L6GyOA
         UYugXoLwfTI//pDjs0m+pH3DtC+wTdEsWX0p04syOieeSD88LrIJcjqcP/P4CQxnPegH
         iknCDy5KvxLSPGDhNkBJWUqMHk3rk0duN1+KOGoTFKcpLskFD/X8IrZX8qHBRyj3icJx
         4xrsI1JtFPBnHAkyyYPezyI4nigyHSUy0PvmH9HcUM7+AroUj99Ff67U2S/897n90uvS
         tWvg==
X-Forwarded-Encrypted: i=1; AJvYcCUxC55/QGMLWk8waz0tgtEmBV/nVN+66V+X7AaDm+NGN39H09+/WkaXWdDVc2Lx9LXAq+2rPJiwUpNrfFvbAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxj6v3gxZfFUHS0Uisy2nO19llafw8wB0Kqh6S2FvLCNR3uUiXC
	vyaAQ7yUSSUfirfoHN62tFWq21a88vvOCOSFnirXvFle3Q4dsVARFOhS9H5xCqAscCw=
X-Gm-Gg: AY/fxX4cLpDUosngqgj2FLw6SGmP7U/OqYUAs28QBXkJsY74rOn0EwrBCAB2lM8TOWf
	qKIdfU76fdxr56pNGvfkVV2CQD4Cl8GmGbencM8zueQAKWRJWjFJHNdAn+moixvnjo6BnV+gJsB
	EgECFuWsJLPB6s3ydLDPLYhN9hO43POcd9Z6fZbQ1p5jD9FQr6bFmbnpm7LQ96s69uAsLopdI+u
	xeCIkPKSXIBNnZQD8PAKkmCIS7gixahUBPuaAAy4VpeK0G9YH3Rom7RjG5jSPlsv3cpx6GZ9eW/
	XtBYdr4wqw+cDGKKjEcZ01YAVGBSNsPUbCJ+fdFaic397pldaf5QA/qahEAv6qKK3T9bX7ygzVr
	hBb9PH1qeWrGVlI9E4muOHED6XlFUQw49GIlK506pyOx1wbhj+t0UCa4pcJ+jAM/7/0D+FE0z9i
	jgnkhCj2JnPIt+nClACjqZPrktfPCoA4ZRIe8=
X-Google-Smtp-Source: AGHT+IGTUeEzz8tNPQ2pmX/MnRbtFTT5HvfYasuVnspclS+oD1dD2L49trQ2Os59ODIZ3jVEB6x5aw==
X-Received: by 2002:a05:600d:6405:20b0:47a:935f:618e with SMTP id 5b1f17b1804b1-47a935f64d7mr172794535e9.15.1766060246405;
        Thu, 18 Dec 2025 04:17:26 -0800 (PST)
Received: from localhost (109-81-80-251.rct.o2.cz. [109.81.80.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449ae0ffsm4488541f8f.39.2025.12.18.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 04:17:26 -0800 (PST)
Date: Thu, 18 Dec 2025 13:17:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
	kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while
 stop_machine()
Message-ID: <aUPw1YFNLf7ONqe9@tiehlicka>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <aUPJuZINNuNxddRX@tiehlicka>
 <aUPLCPAyxkPeBaoD@e129823.arm.com>
 <0d08b4bf-35c5-4c63-964b-ef886b8262d9@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d08b4bf-35c5-4c63-964b-ef886b8262d9@arm.com>

On Thu 18-12-25 12:02:14, Ryan Roberts wrote:
> On 18/12/2025 09:36, Yeoreum Yun wrote:
> > Hi,
> >> On Fri 12-12-25 16:18:32, Yeoreum Yun wrote:
> >>> linear_map_split_to_ptes() and __kpti_install_ng_mappings()
> >>> are called as callback of stop_machine().
> >>> That means these functions context are preemption disabled.
> >>>
> >>> Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
> >>> __get_free_pages() couldn't be called in this context
> >>> since spin lock that becomes sleepable on RT,
> >>> potentially causing a sleep during page allocation.
> >>>
> >>> To address this, pagetable_alloc_nolock().
> >>
> >> As you cannot tolerate allocation failure and this is pretty much
> >> permanent allocation (AFAIU) why don't you use a static allocation?
> > 
> > Because of when bbl2_noabort is supported, that pages doesn't need to.
> > If static alloc, that would be a waste in the system where bbl2_noabort
> > is supported.
> > 
> > When I tested, these extra pages are more than 40 in my FVP.
> > So, it would be better dynamic allocation and I think since it's quite a
> > early time, it's probably not failed that's why former code runs as it
> > is.
> 
> The required allocation size is also a function of the size of the installed RAM
> so a static worst case allocation would consume all the RAM on small systems.

Understood. But is it possible to pre-allocate early on so that the
allocation itself doesn't have to happen from a constrained context.
-- 
Michal Hocko
SUSE Labs
