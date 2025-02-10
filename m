Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00A2528F4;
	Mon, 10 Feb 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199825; cv=none; b=egYMR/MMDS2LTa4/2/Tholug83G76sqVpzdpQ3LqmQgKDYUwjAui2V6IHjgdV8KZNqE8yZuMe62qa+AkxdfI0ZgpLV66tLlUxQ/ng3EPUTPxTX0H6R2KsH3Y7TXXUT2PaRTawLf/rqYLYij4CDgTLdKRijlW0nKSYfiVZ50Ei9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199825; c=relaxed/simple;
	bh=8CYs7UScYRbBksTKxuHuJ5vtjzDxeXmV0V9sf77Qyko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXLilvLY6HVD/tee3CIzU6Zavcf+YdroE0k9PNV6tjrrzT7iS49ERkfXjiSEdVdPf9eWvMiLE0FGBax4SAcpiSXZsaf5kqgm8sX908NaMPuwmLmTNTmm7p7bztV4g1bPkZscEJnCqIm1PHN16XF0G88lJlUIQT/DVheiXeeqPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOBvXMGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOBvXMGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2074FC4CED1;
	Mon, 10 Feb 2025 15:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739199822;
	bh=8CYs7UScYRbBksTKxuHuJ5vtjzDxeXmV0V9sf77Qyko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOBvXMGPHI4ya+tqEL+XKcedObEId9kWSttOpm3xA6UyBw1V7zRmuXQlNq1l1zK8C
	 UGov5mvt6xPA8quHY7T/3l0QWr21cbPhkJ/bQPIXLP74FSdZVhiXalSXG6eUfiqcvC
	 DwztCKLuy4pMlbXh6nuOHWT8JdN2RF9otjc5eXvimJadcPUUoqO6Ns6qNWiHsI3XDi
	 /8ib3EjUDrECUZGXcUWwHDdQTsQhdrxUydyPGZu80PojMqvPgtcKoP3WAKzq1Nw63e
	 /8aKs6x6qqgSIjSAfbTC0zlaw/1m+UXXhGr5GWtUKA+am9izmCvUAZ5l7LsgrnCVJP
	 BcQ4FdTDBGZ1w==
Date: Mon, 10 Feb 2025 15:03:36 +0000
From: Will Deacon <will@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/9] arm64: Rely on generic printing of preemption
 model.
Message-ID: <20250210150336.GA7568@willie-the-truck>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-5-bigeasy@linutronix.de>
 <20250210120522.VvikzMr_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210120522.VvikzMr_@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 10, 2025 at 01:05:22PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-03 15:16:27 [+0100], To linux-kernel@vger.kernel.org wrote:
> > __die() invokes later show_regs() -> show_regs_print_info() which prints
> > the current preemption model.
> > Remove it from the initial line.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Is it okay, to route this via the sched tree?

Fine by me:

Acked-by: Will Deacon <will@kernel.org>

Will
