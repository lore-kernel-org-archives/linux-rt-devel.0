Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9694D36B903
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Aug 2026 03:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785901246; cv=none; b=T04lqoBlCbm+5MqaFA4Teq2WN/ogjx91TjloDYeSFtAWQ/t6ozIJ53giXgmgSlE/McKwulN6dqH2Un7PZN5VvoaGdLcKG3FKG9mTye23JPaMgIePwYQcNsXHaVOg8w7r88VGZcRHah1lahEEtD67BRMeMA3nQwEMLWaRsYQFds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785901246; c=relaxed/simple;
	bh=9bRo+Ywi3z6M397Ttk8WJOCfNaXfPL/cDqxTv2yA2Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krfLxs+iTjcv04OGpuHsKD8u65l5QNVaxvoN+FO+nQJqOjcWFBmETHM6lyelMuSjfsYl25V0VxPDwXfci2dqJKoP2iPTZrkyX22IHHJ9+A/fIQV/84tQ1XPwEq5Qcenx9j5iYCppMrFE2p0Pvb2pjgpkh/Gz0DgTqVjsuVzt+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kz+9L+Po; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz+9L+Po"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d004f135b1so6731065ad.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Aug 2026 20:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785901243; x=1786506043; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3uhTNsEfEA4V2HM2KbClDOzdBojungNZKQ+/eKrllo=;
        b=kz+9L+PoDDj4tyoI1VR0HgxcUnTelM6ZAtZYi8VTpttzP/51lyZIMzh0zZ8q48HDqk
         D5JoIk6ajfxRCMz4VIrscdOCnZMg/nNiOAzwcugPcebV4w2XuMNiwYnA16Lc6f5f9HQO
         xiXbXi6g9OupeGsWfn9MEBpB7EellUAyAdIUSmcbZrDep5+5vHDWJN845vdVSAIG/7HS
         Yil26dxECPiQs371+WaI5sjKIx0MpgS38lbJnlWDJPvpz7ISBlT6qqauQQ4V8X8t54ed
         6XYiACzRHOk3oBRYcwYJunyr8IC5/nE4pfOQuqEKOxS4w9YiMm/FHOwpSbTIJQ5CN63k
         nm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785901243; x=1786506043;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b3uhTNsEfEA4V2HM2KbClDOzdBojungNZKQ+/eKrllo=;
        b=n7KBSiO/gd+E3B9hl4Si9W1lz9vOQwkWoYt6mJmHYoBAf3V9N0nrx0CNlGqHUBsEuM
         cwYBb1hIMciwprp+cc4ZihahzFsFpc13lhd0TRmIMEVA+pTnXomILutQxjFVanO+DFV5
         YrBYNUzRoW1uqu/2OP4CFLYjQ/3cz9fNOXIMCBV7GevPBcQXvqidw8iThjWHFRJCzJbw
         oHFWJw2qJ5I44MypE0Lwq5QgsjhptvjYaNIEARwrWmG5BntK6kA25YvtnVhxyJplNhvO
         vz0zDHR1eyKRlWn6+ge/9HUBxirwF4VJoLYJMw2H+1EL/Wi2Nyuk5rtYpZg85Cy3L/lA
         tdJA==
X-Forwarded-Encrypted: i=1; AHgh+RpcxQIJF6TduJhXnL2gaXgdWWSfmimeC80QA0DLGdZPv7SbY191tYm6TiFS0KwHSNBd/COjY3RP5AVM+ky5+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNDSqkkyRR9FrIH13M2ODt9JT/kBh62n6PyV2WlltiqmNxyPo1
	JtAh6LQ3R8U6wFPTs9uHVlO/dLWS/Go2fcy9YvkgiyxR+n/3qwgn7QB/
X-Gm-Gg: AR+sD11eTHLtMjJqQ4/JXksmDCmr69+LX5P7FHqRjyuyEaq4RM9dgm96EePJPgBe7ft
	xPXryq5Fd7SXotUN/gsU7sgBLDqvxsHiPdAh8RkQkI+ad5KmBH7F+lR/y+GXjYmUTPAcqf331N7
	PKHm++cRFBr7QiLFxpH83+Sras35RZOX1JM2HPj8JKxAKgUbekJtL1Oa67WPs5VEl3Phy9D+qNr
	ZOmhbTPvQ5NvN7bXt5SJuCRSPt9WX0YYfhqJx8SzB6JaR+gVnq1XJ1EiAMun/9fMQ62ezBbr4k5
	CkgmteULGP1FhKKrTvuMJZHJ1lG6KB9JrBp/GqFBJwyIocyer+0mmsj6v6ZLajSas+bw9AuAIIX
	sFwOhAZZjRd5rPRrFPmgjuTxt2FCRZgJ+Sh87jz+QzWvi5w0jOc+7QP+WkVZboK76aFLpqIsYmc
	IarP5FRnYvyZBfJ88xIiUjSpUf2siTMinEwQHj8dvTvHnpVeKXAbOZIcL3bQ==
X-Received: by 2002:a17:90b:1811:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-3903bb0ab77mr3022104a91.0.1785901242802;
        Tue, 04 Aug 2026 20:40:42 -0700 (PDT)
Received: from x1 ([184.3.251.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903917a5d0sm1534085a91.6.2026.08.04.20.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:40:41 -0700 (PDT)
Date: Tue, 4 Aug 2026 20:40:39 -0700
From: Drew Fustini <pdp7pdp7@gmail.com>
To: Paul Walmsley <pjw@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn,
	James Morse <james.morse@arm.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Newman <peternewman@google.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, devicetree@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/8] riscv: Detect the Ssqosid extension
Message-ID: <anKwt4llzgwySljb@x1>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
 <20260729-dfustini-atl-sc-cbqri-dt-v6-2-7c22b05d461b@kernel.org>
 <c38f0bfa-54fc-d141-c166-7355901d8ad1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c38f0bfa-54fc-d141-c166-7355901d8ad1@kernel.org>

On Tue, Aug 04, 2026 at 08:47:04PM -0600, Paul Walmsley wrote:
> On Wed, 29 Jul 2026, Drew Fustini wrote:
> 
> > Ssqosid is the RISC-V Quality-of-Service (QoS) Identifiers specification
> > which defines the Supervisor Resource Management Configuration (srmcfg)
> > register.
> > 
> > Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> > Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
> > Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> 
> Thanks, queued for v7.3.
> 
> 
> - Paul

Thank you for queuing patch 1 and 2. Can Patch 3 also be considered to
make the Ssqosid CSR handling complete for this merge window?

-Drew
