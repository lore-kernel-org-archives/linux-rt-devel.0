Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AD82DAFB0
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182018; cv=none; b=bepW4HlJ3sWAxyTp71vn7RDAQGy7jPNqbAdlw6ahnZI68otrZLk7RNImj43adc1d8NPiQ9hMxOpVhS0xIbLTmJhw903Mw3Kic6lwqoGCHCPDun7fbiN9Rhkck4JA7IChvll8m8kcfxBDq1rpTUyOaE1Q+VtulDlzWvgk/YmwIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182018; c=relaxed/simple;
	bh=/6q+M6uD45nvb/X2LSm00sZUsxfBu9F0W6sFR03NtXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spvCNVfpWv+lRfqZJsCh8wPec5QlKX4zoEPdvilUYKgvxwCqG9ccMFRtsfLWMsy3J65xcqT29D8H1B580kv0lq+wUvDDg5x+P0thLnTbJuLfEtjiepZQZE20zhFXV+DlhyufWLCBxxTehB44AF/36XIsBA0q5uM04YEo54n8aGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B56F91476;
	Fri, 23 Jan 2026 07:26:48 -0800 (PST)
Received: from bogus (e124108.arm.com [10.1.25.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C163F632;
	Fri, 23 Jan 2026 07:26:52 -0800 (PST)
Date: Fri, 23 Jan 2026 15:26:49 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/21] ARM: versatile: Remove IRQF_ONESHOT
Message-ID: <aXOTOSAGFf_aqcpa@bogus>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-9-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123113708.416727-9-bigeasy@linutronix.de>

On Fri, Jan 23, 2026 at 12:36:54PM +0100, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> 
> Revert adding IRQF_ONESHOT to irqflags.
> 
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
