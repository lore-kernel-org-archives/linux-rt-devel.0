Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662311D5ADE;
	Sat, 27 Jun 2026 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782598207; cv=none; b=d6u7xfK598nHgtl8M0mSBZGM/LxwiZBLUaIv6+cIxtR9mc4ZG3N6YYjjMvKYqUeGuT8ggPLtLzIp72FdhfXTLg0BBGSOOpWd+nLtontzo/2Wj1hAde0ZmktbPOY8hSkbt8WndJjkyvuoLcxusgFZwcjopjPsAZVSYOD/wmMajNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782598207; c=relaxed/simple;
	bh=d9G+ljKEjOva0maSSJ1JxkRDkBP2lZWCTnWq49qSDUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM+tHbctEhiwyMfkcrMuXm5tKe5ANPrqGcDW+SE8L/Vn0GHwjA5sSkVpS3XlWmeSa2+uU+jPD77nMNY1ZlwZx/zFQ+ef4honbRtPXbw3gDNVARbBMZS3G7Zo8Em6WkkzESX0p6KhFEJIqIom6RjRUd3HjUdt3LYzxkD5LsncrbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwNrxQgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwNrxQgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C491F000E9;
	Sat, 27 Jun 2026 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782598206;
	bh=hXk/3wj9lPuJCQvYpjGC/6+kjVjcs5SuF2pwhCfblgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KwNrxQgJVN8O/LbbNanheVHNF4seUkCijI6JBEHt+/pVyaoyi8GHna1M8j9Q8rFwy
	 vjYXsheeYMBZZBM4h46nutz/29QBslwVDHlDG8v14K9zWPf8u3Q0TsPvzEpqNPULIy
	 Ka+qEUM7TFWkIGMxpp+GaHihtgYKrWsLDXEZx7dizRfq9smMXkoYJR6bCLe6nSuNeo
	 +kUpVcIbVWV/WYRzdY/1rCdNllhLfi+cVc+AVILwSEZ7UXYXPTaq9jk7fhok7zkKiY
	 12B+J7VadfIPGgB4GEVSueOD6eHRiMYmLCCaiWUf6BRtOeLtSgLeXhN11rAr22sK93
	 rFkVT4B/TcJCg==
Date: Sat, 27 Jun 2026 15:10:04 -0700
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn,
	James Morse <james.morse@arm.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Newman <peternewman@google.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, devicetree@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [External] [PATCH v2 4/8] riscv_cbqri: Add capacity controller
 probe and allocation device ops
Message-ID: <akBKPFPi5213WgYX@x1>
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
 <20260624-dfustini-atl-sc-cbqri-dt-v2-4-2f8049fd902b@kernel.org>
 <CAEEQ3w=ZVtHPdLfN0tTzG8AACu+rjhEFWY5pCg+uxvmr7ofqfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=ZVtHPdLfN0tTzG8AACu+rjhEFWY5pCg+uxvmr7ofqfA@mail.gmail.com>

On Sat, Jun 27, 2026 at 05:31:03PM +0800, yunhui cui wrote:
> Hi Drew,
> 
> On Thu, Jun 25, 2026 at 9:41 AM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add support for the RISC-V CBQRI capacity controller. A platform driver
> > passes a cbqri_controller_info descriptor together with the cache level
> > to riscv_cbqri_register_cc_dt(), which probes the controller and adds it
> > to the controller list.
> >
> > Assisted-by: Claude:claude-opus-4-7
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
[..]
> > diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devices.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..8ad9df404f65d5d82722cf8b78f02936c489ca6d
> > --- /dev/null
> > +++ b/drivers/resctrl/cbqri_devices.c
[..]
> > +
> > +/* Set capacity block mask (cc_block_mask) */
> > +static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
> > +{
> > +       iowrite64(cbm, ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> 
> The CBQRI spec allows naturally aligned 4-byte accesses and only guarantees
> atomicity for 4-byte accesses; 8-byte atomicity is unspecified.
> 
> Would 32-bit split accesses be preferable here instead of relying on
> ioread64/iowrite64? This may also make the driver less dependent on native
> 64-bit MMIO support.

I suppose there could be systems that are RV64 but do 4-byte access for
the CBQRI registers. You are right the spec only guarantees atomicity
for naturally aligned 4-byte accesses and leaves 8-byte atomicity
unspecified.

I will switch the controller register accesses to 32-bit reads and
writes. The driver rejects ncblks > 32, so cc_block_mask only uses its
low 32 bits. For cc_alloc_ctl, the writable fields all sit in the low
word while the status and busy bits are read-only in the high word. A
read can reconstruct the value from two 32-bit reads and a write only
needs the low word. 

Thanks,
Drew
