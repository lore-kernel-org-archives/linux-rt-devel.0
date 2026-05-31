Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10C23ABA8;
	Sun, 31 May 2026 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780192273; cv=none; b=Fy+0l3O7IMVaPRhEzasK1PZf8a0S0jFpN9bZ6uUagvngbnEc72MjO/osMAtG3bE2FlBmSLG+TO+MExfHjKg0q1CNcAHcchNvKWElmaOJZ4+RErWtwwnSmm2SaJUVN+Y4APc87kGyctFnP3KU3Y/5KwhC1Tg0jEjh6IX1r9u3hhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780192273; c=relaxed/simple;
	bh=kgQ1INYmGkCFtHjfF37gquvimy7OqaTM1L0UoNYKxYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOQANcTBLAuCpVOZ9xn5GeuNUbrKac6hgwvH9ZlSecWYCLN3SjzfTJtXhUu7IDrUm3U0PgBsxIkHFxyyxLPX7badlvaxngIqONlufU3TI69qRExLIFWEf0j++ueT7wK2p+KGODds3ntCHliROwPsgxhzPKdCA5zLTKlPjo1wrZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLY60Wfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLY60Wfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766BE1F00893;
	Sun, 31 May 2026 01:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780192272;
	bh=1miKEZAnGiSRcJQWtswcD5dFRkY3BK0eDKYXOh7h6zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kLY60WfhyXnSawaNZl+ilX4Ak1L0nLfHZVo5wooZbVNLdLl6+VwBm6FBMlSa46wp2
	 RhTtMwa0RiiIopa/dJ6a4pY7B1OWJ6JG6HV0TQp+U2W/HKI248r6TyYHbRTreyNyVz
	 yUz2338GeKxTE6CjYYCC6b361QBAF7FbhAnXKsfdt2WOCXOxGmOr6XE4nuBsWSm68w
	 aiWbuaU68w9QP8FiUzIoZ1Bv2H7Ru5HQw2gQGmLT2bdMaYe7+sdfPcvgs8KQZWMZpX
	 upA3cR23f39TzrUVNIHAGvC/dbMTqphfDDHLjSUuECnm+NaeIS8qJ8xIn5Vit4bcaE
	 MoQcXwuCuMEJw==
Date: Sat, 30 May 2026 18:51:01 -0700
From: Drew Fustini <fustini@kernel.org>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Atish Patra <atish.patra@linux.dev>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn,
	Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
	Peter Newman <peternewman@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	devicetree@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor@kernel.org>, linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v5 16/18] ACPI: RISC-V: Parse RISC-V Quality of
 Service Controller (RQSC) table
Message-ID: <ahuUBV8QYo_ToOrB@gen8>
References: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-0-78d3a7ba9dbe@kernel.org>
 <20260524-ssqosid-cbqri-rqsc-v7-0-v5-16-78d3a7ba9dbe@kernel.org>
 <CAB19ukE9r_V=0eop3=f8zohhnCavd=9GjDEK1VMMbOb0ReOtDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB19ukE9r_V=0eop3=f8zohhnCavd=9GjDEK1VMMbOb0ReOtDA@mail.gmail.com>

On Mon, May 25, 2026 at 01:53:09PM +0530, Sunil V L wrote:
> > +               if (info.mcid_count > CBQRI_MAX_MCID) {
> > +                       pr_warn("controller at %pa: mcid_count %u exceeds CBQRI_MAX_MCID %u, skipping\n",
> > +                               &info.addr, info.mcid_count, CBQRI_MAX_MCID);
> > +                       continue;
> > +               }
> > +
> Do you also want to add a check for the statement in the spec "At
> least one of RCID Count or MCID Count must be non-zero." ?

Good idea, I'll add a skip with pr_warn when both are zero.

> > +/* RQSC v0.9.2 Table 4: Resource Type values for acpi_rqsc_resource.type. */
> > +#define ACPI_RQSC_RESOURCE_TYPE_CACHE  0
> > +#define ACPI_RQSC_RESOURCE_TYPE_MEMORY 1
> > +
> > +/* RQSC v0.9.2 Table 4: Resource ID Type values for .id_type. */
> > +#define ACPI_RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE     0
> > +#define ACPI_RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE                1
> > +
> Memory-Side Cache, ACPI, PCI devices missing?

I'll add the constants for the future.

Thanks,
Drew
