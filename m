Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2D389DEA
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Mar 2026 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933874; cv=none; b=SKjCZO93hmiD2PtalRV4Hv4x/YAlsHvJZoc8jzd/x+nWGZTmQlMYz2JAKS2yk8dNo/rBXtcOo7meaqMyxAb44L+PN8i2zviL2P7iyKodW9dofFYWn/kO8t0h4dpV1WkEFaJHcZRpKkC8yPBt9Z6He7QB5Pf+ezQOvv1UpweZmGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933874; c=relaxed/simple;
	bh=pg6Bqlz4hp2TL3LRD1rOcSMVpMNVbsxv6jOeSgguD9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwTXfWJ3Ku8ORSGwEjc4F1T89wWoqLJjhFzKFGLospYcC3TRsKNiMih9RdNDxhZs7LdcTI0tbbgiNcg5AihfNeCZKlZd6ZdV1H0RQ6L71MLiAk4Mc+7gq0SVl4WmYqpBSl7i5nl7no6YyJprMcfMjgs2FnFFmqFcsAAQ+vkmuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tqxEnR3d; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tqxEnR3d"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899ed41208fso17356006d6.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Mar 2026 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773933871; x=1774538671; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAHdFeNRl4yy2sR/1LOHb2d72hyJTySGsjAok8mzB+g=;
        b=tqxEnR3dRPDLVW+mU6+H4RC/ihtVEjKlOiyg2ORORk3q9vrlklauD5p8PXE59PQpxl
         RHNfWtqjSexGD6V7y3beYpdEDDKAusLOgPq8uKVBWBmCZbD9ZmOLftCKeF+IGCafcjFk
         oGjtnO3z3qrlgoDxRMB0Ap2fOG5SiFVjQZV7vKuce3CAOSuR4qvdZg8Dah0h++PAGchF
         LhNQ21Yqw7EieB6XBetqAUfGZaw5MOmWGgkcrqL1K1fRcwxHcJXrBPv0rBn4yc1+ynC0
         RTKhARYQUDHIvPb7jTMHu6ZvWXtpsKjLC4/aRHJxrZzloa2/fGxbbRRlSpHRCCcDmi8a
         AcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933871; x=1774538671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAHdFeNRl4yy2sR/1LOHb2d72hyJTySGsjAok8mzB+g=;
        b=BZJYonwSLlhky/Wlpr1dH0/MAokM4xn7NiLSZYrA9AwI2lOk7bevQNKnqLBNtsSDm0
         h3HeO571ryt1RGj9dzg+TsHstCC0++k4nZ+Mn9jHG4NxVd7KPxDWMtn807ByJJMuHOSV
         Q0aDugtReCPfdFmRmM3rhnPe3oFyL3s72MEnHmpHca1OtMr+iLi+XKNEAwOjB5SOdCJP
         7Op3cpFqb8XmX1cRSfbf/vg/JBahmFoXmYH51sj9mbNyA7mS/GocSM2zEsxNqhNPJKCf
         gVJYSvZaIPI3rToH6iwTYxYvoHO+amBNdtAuOebM5gQRwFdMF614TqhX6ANKdqOJT12l
         cFUg==
X-Forwarded-Encrypted: i=1; AJvYcCWAHrH6y0AiUegWLt4Q9mDnLKdlM0AhxwYgonjOh4mxrdUaJbBSv9UhBayOVisZd5Ue51fbhEbFOcAiamMSsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxDfcVsnPhUBfvH8euss52gTRZWFEwqB1R0AMKyQoaoAQT3bNt
	00Z5dtQ9vUgwdS/6d43T2DnAF9E8Ix+2UZYLsXosYVuL3FdaMI6/Ma3twHPPPQKA/mI=
X-Gm-Gg: ATEYQzxGXMza36rUF8Ziz8dnp1RaYxi3oG566Rp1e1yB4vQy4MhZ1/dfAKSF1zVQZtT
	3u+6o+Kgq4G4K4VtGvxmi2DcUA3u/IMdNEJCkiAw+E6vbQu00tz3/ppf+vhhuPNpDOP5RPrawJG
	fEf0Gxa/GWWSlcJKfwZGt9w2dg5IXsBfnnE9t1Fx8fa1Btca0OJoKiYDtF8/0ZgW2Yn/TCY/Cxo
	+43Fo4VwYhyv3DcdnUIx27/SQGPLZKdAIz9CCEnnjBb26iZAszPpgUL+xPnYrGfNYr+RyLKDegd
	wGANDCfaAON+pG2kGagmsUYpfaGzuOXkZ35bTQ0Ccws8jKS35ZSug9YfMTk8z+ODIq2FZzGpqpa
	+uCrK5pjNE0Q/0nHw1uV1S0qZNSdEtHRJuxoQoRlCQ7PPZZMDU8okcwmMyCbeP3UH2rq/DUhxxw
	8Fo2biRCOSON/AKuCRdZm8pykkj+B83vVrSbAn0FJXgYVSFEngG0h3PIUOAA1OwmW5kbR6M9vff
	oFmpyUWyw==
X-Received: by 2002:a05:6214:3314:b0:899:e702:b852 with SMTP id 6a1803df08f44-89c6b5fbac4mr107205736d6.57.1773933870639;
        Thu, 19 Mar 2026 08:24:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8dfdf6sm49250646d6.5.2026.03.19.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:24:30 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:24:27 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Message-ID: <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-config_migration-v1-1-42270124966f@kernel.org>

On Thu, Mar 19, 2026 at 09:19:40AM +0100, David Hildenbrand (Arm) wrote:
> All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
> select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
> 
> For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
> and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
> CONFIG_CMA and CONFIG_COMPACTION already do).
> 
> We'll clean up CONFIG_MIGRATION next.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

HOTREMOVE has long been a thorn in my side, I appreciate you cleaning
this up.

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
