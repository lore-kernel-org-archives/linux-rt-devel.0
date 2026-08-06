Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290373AB289;
	Thu,  6 Aug 2026 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979274; cv=none; b=XZpLJHjOpBzythc6cX6eQ9TpzHxD2awE3zlIM62tCs+iooxzqOE15elLbCL4S/GELnHIuqlVXvj6CLGm64tNkIi8HbBLX0Y7bVTlANtuJEVwBk0NukBROlqO3RAx5hwY6Mf81yWD/6n5JCt8LVdsZu1GxJtmr9LMa2ZyI71yfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979274; c=relaxed/simple;
	bh=0P6er77yxOQAHda1I+NPlreAN19z90eBknaLSRxsUAM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kuQwdhEPFx/5hPfSA/N4uZxxAtaJiDL7jljoL17Ps0ngdMRnk8VCgZi2NcPm9YrueqBfYZHW/pTY9miq++kJHzmMUtCzdRi/EnsPaY9D2h+WvJu5AoZsu9PdR2OOSnYe9r2gXb2gAt0bmdbbYbSVyAHJX+6w6VagNLLbV1jsUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuJaJ7Ca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuJaJ7Ca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0961F000E9;
	Thu,  6 Aug 2026 01:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785979272;
	bh=hDGqstzzjBKEwA87lDJOzh7sqG1Xvv3RgfgKzbRXTKc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ZuJaJ7CaSUNULH/y7SLUAu0fEGbuBeEu7FyezYtiybDTQ8Pa/foOX0STx0NeHytEb
	 l93xuHs0Z+E9Z7Vc/TnyskljCazpEUdompRI91EEwPFabhE6+bBP8onlxT+Y0OXKEG
	 iGa3n1WDx51n1WNF7xMhNBB9O+udscqJ0jggSotCNIJ/GrhzNzapRPgXUBj59cK3jW
	 6+W+4GyKkPhv9+fOjnWBBMecce3rdE441E4hgON18UuyHDU4ggVzAZZ389yLe/x9/T
	 ikjF9UEL2cNoxo++KOjOxXCBf+/WmS2FEyqCt+5JakJ/b0bHxqVS/Ii3Y4nN3zfgD0
	 tKbEbA80Pc0ag==
Date: Wed, 5 Aug 2026 19:21:02 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Drew Fustini <fustini@kernel.org>
cc: Paul Walmsley <pjw@kernel.org>, Adrien Ricciardi <aricciardi@baylibre.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
    Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
    Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
    Chen Pei <cp0613@linux.alibaba.com>, 
    Conor Dooley <conor.dooley@microchip.com>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>, 
    Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, 
    guo.wenjia23@zte.com.cn, James Morse <james.morse@arm.com>, 
    =?ISO-8859-2?Q?Kornel_Dul=EAba?= <mindal@semihalf.com>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn, 
    Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Peter Newman <peternewman@google.com>, 
    =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@ventanamicro.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>, 
    Samuel Holland <samuel.holland@sifive.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
    Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
    yunhui cui <cuiyunhui@bytedance.com>, 
    Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
    linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
    x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
In-Reply-To: <anOiJHmU24Lpbizi@x1>
Message-ID: <c6d85325-7ba6-57f3-62e0-9ae843c98cf6@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org> <20260729-dfustini-atl-sc-cbqri-dt-v6-3-7c22b05d461b@kernel.org> <3b6dd35e-dabb-3cb0-547f-0c8a0b035e1a@kernel.org> <anOiJHmU24Lpbizi@x1>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Aug 2026, Drew Fustini wrote:

> Thanks for queuing this patch. It is okay to leave out the READ_ONCE()
> since only Patches 1-3 are being applied.
> 
> The READ_ONCE() is meant to pair with the WRITE_ONCE() in
> resctrl_arch_set_closid_rmid(), which comes in patch 5. RCID and MCID
> share the srmcfg csr, and resctrl can update thread.srmcfg from another
> hart while this task is switched in.

OK thanks, that makes sense; I've put it back. 


- Paul
