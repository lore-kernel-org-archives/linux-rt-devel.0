Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F21A238D
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Dec 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754018; cv=none; b=m7+lSCqrwCCdENqQyGO+GuSWwiZrGMF8cVq+K1uQ7deLfm3cN5PckoIL90V9EFRuwqBjBUG9PIlg9kZyjsJDVi7fpNESm+OnSrkhk98OiO0UYf5O91ssnBIOPGK+42X7XPAzV4LJ6P4E4EMMdBQF7SSFtrMoI5vUcG9wRlzPmYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754018; c=relaxed/simple;
	bh=1IfxwKOe0K+SXDwRfMDias6ZXlgFg4AGO8kVbL4Ta8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou6isDMGqtsnaSUm/buxHOiybk9z5Lg8jYNdM3+EH6RZXJp3JK+cS0BVwgH8AnceBSv3GqerkGzCXWkbg3VD4xSzOtovSHgSZ1wyLv7rN+tIFYJZvWaExwGBKqeB66D0HpK0EeEd8RfQjbL/GoQd+EwWrjTVFwmE/Dx5T0joD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eC+fVs+d; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eC+fVs+d"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d87fea84cdso33303266d6.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Dec 2024 06:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733754014; x=1734358814; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nowhEyl5dI6aIIqwammoplLG7dGCizfgN3AwcDBvNB8=;
        b=eC+fVs+dszVuAWM0+rQF/Eo250gW1JXHQRQnqD2ykLz0nGUg3t4llMvUAF+BcYGrUb
         BhwNXDovaOLiDyJdqQl873/57/P2hPTFowJgX1zsNopH4MjmP61grVwc/dLDox4G7+dd
         r1CrR5xqvqCGvN4HB1WcmAOB15nnxAQfihaQv1alvXh3Ld6OSv3YjuYs8frgsbTSorxA
         Ls7UocLp5u/v1TnnC37lBUegMzMefiT5ia7fNhoczaxDRn8cMTlyrzJb8EFv2DcV0MlR
         crssuNri+ZgVNoaCO/vMxxmhr7m1wc2hF9lPpSPGJ4/hvu7M3gFskrsn5Cd5COxjc2AN
         E+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754014; x=1734358814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nowhEyl5dI6aIIqwammoplLG7dGCizfgN3AwcDBvNB8=;
        b=mBS/nG+0ZmxZtr3rxuMXZSIdR17dgdZYu/JZwgfa0QDi2/0MRfOKJfQgq92L2tBcZq
         +h1Cubrk5J/xpNwn3dF/vs8X6xB1JSeXpqx9c5E91LX83fJ1q1CpHtyfHkfgavp8rxgu
         NXTurmhiDHMCzCWHWlh11PM9HB8FYKhXAk3NfT1cgB4aJduc6vnmQX2jjqjHpkCxaNSL
         SS5JM9Dznw1V/M7XyrLDW8bltya4CBZ7Eavz78k/s1/5lagHXfp0PKnihl+jAhmxb4sn
         ZOUZqU54s1BeLwyYp4u0hEEBlBHADvYfwPnVbkvBWE3rkrkYVQ5/W+KwGyQCzwO0TS6F
         u5/w==
X-Forwarded-Encrypted: i=1; AJvYcCVMtLGYzqdG+coo0opU0DuSH7uofgWPUp+AbQ8KJ3wP9zyDVYF5Q7VvfKz3BWeEGGRu7cUczRQlUtoPu9wqZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcSs4L377G6nCXaHsJt4wxmHOWhWE/IcKDaHkrQaTOuF9VYQGs
	p3rQ7hvxvtLwBbVQ4mxR1TwyKxEoEv1e9OWZvn31oyj1fAVnd5s1x0R020RTF38=
X-Gm-Gg: ASbGnctk0HqzSENT742/wh7a+jWcZ29avFLIPjQvtle/cg0vCsSv9RB/TE/EwtXpC9M
	CRVyFUN2TXW0nghrV/9H9dDv53ij/M0OGNEmLifwpvyF6Ecg9bQK2XV5pIUwVtlbYv/qyQPcmD+
	Pb2G2Boc6hnaKYsdLCOWFJlXYUf2q39rApyY+RZOdT47XeFdIRkqIZt1f2j02rN61JKpZN98BzF
	6fQrEH1UAobqCL+m4CLuihksVWBsOpwzXaz9NtVa/Ba0AzTzK6wfMQu9S2sunt4GyJBPErnIfsD
	LI742eYJfWsyO0Bgvn5gdGQ=
X-Google-Smtp-Source: AGHT+IHoY1ZOiHkAJnpdjYQRkeVDy7sffj3Siw+V0OMHlwsl39yE0CXPuxOPKOgDNwcCNM/wgKH60A==
X-Received: by 2002:a05:6214:1c07:b0:6d8:a76d:b66c with SMTP id 6a1803df08f44-6d8e7170365mr191037006d6.30.1733754014582;
        Mon, 09 Dec 2024 06:20:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b2291sm48868886d6.58.2024.12.09.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:20:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tKecP-00000009sI1-2JGA;
	Mon, 09 Dec 2024 10:20:13 -0400
Date: Mon, 9 Dec 2024 10:20:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] iommu/tegra241-cmdqv: do not use smp_processor_id in
 preemptible context
Message-ID: <20241209142013.GC1888283@ziepe.ca>
References: <Z1L1mja3nXzsJ0Pk@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1L1mja3nXzsJ0Pk@uudg.org>

On Fri, Dec 06, 2024 at 10:01:14AM -0300, Luis Claudio R. Goncalves wrote:
> During boot some of the calls to tegra241_cmdqv_get_cmdq() will happen
> in preemptible context. As this function calls smp_processor_id(), if
> CONFIG_DEBUG_PREEMPT is enabled, these calls will trigger a series of
> "BUG: using smp_processor_id() in preemptible" backtraces.
> 
> As tegra241_cmdqv_get_cmdq() only calls smp_processor_id() to use the
> CPU number as a factor to balance out traffic on cmdq usage, it is safe
> to use raw_smp_processor_id() here.
> 
> v2: Sebastian helped identify that the problem was not exclusive to kernels
>     with PREEMPT_RT enabled. The delta between v1 and v2 is the description.
> 
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Makes sense

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
