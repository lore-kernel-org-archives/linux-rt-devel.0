Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4121CA1F;
	Mon, 17 Mar 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202879; cv=none; b=sY5wizCiVAvDHNCFoqQkUqiRkR0JLJ1JeS60wdWBeS+XC6Bbp3+xvRKyF9icVm3viM2TYWIUiDWtxHsKqEmIw1W57TgVtW8cvCpS01cueRGahNznf6hjK9ZN5zCf98QNtTCSlU8gmppCfxiH9l7L/CiNcbgdQG0j0VR+x4eTl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202879; c=relaxed/simple;
	bh=5h8XMT/G+RV7ujcpCBjzHgGWuv8EYmnCD8h3KrbDJkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1HCdPuOKpyvROt3BWPDMyX0OJZHfH8PVdXW2QKDE4lhbXUFTX7ztvdhOLcwBS0sjwSs5LLcNRnIJ+5BYIKUjrdv2x3k6tFrKshqdJXfhIe3L1BjVIzkTbusX/4GEWiNVB78s+neAQSioSG8v57k99ewJt/KNDQxES5ZMb2zBaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb8Q6hDE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb8Q6hDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61E5C4CEE3;
	Mon, 17 Mar 2025 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742202879;
	bh=5h8XMT/G+RV7ujcpCBjzHgGWuv8EYmnCD8h3KrbDJkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sb8Q6hDEkFRa5N136Cq6eHG/h2v14EuhqwY95oppqXK5OKSPCBv/uOraLYd/6f7UH
	 rqWvQxXTTCLU2qvwjF2S44zi1HrOPjWx5izI3cpqaQ8yw7gvzSDpjZOPX1+bIcjsIw
	 9iSSCXtPv+ML7IXItdh6ZtHTSDPf0g9IO1yx/1hpKJr5Cr8By3+Tg745SRmKStyk1r
	 FAGjUpx5bNlKllyWp6i7b63SnH8/BbdI7r7kixiy8evDrg+8CB/NnygxocRzAe0F2H
	 Z7jq6xvBdJGKvJDxEQvaT2ozS8mejK78PKU5JZnWntCyWxTwvmNRWgF1zFLThNroQ8
	 1/cXhCknUA6Jg==
Date: Mon, 17 Mar 2025 10:14:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 0/9] preempt: Add a generic function to return the
 preemption string.
Message-ID: <Z9fn-UqDPXEr8vs-@gmail.com>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Sebastian Andrzej Siewior (9):
>   sched: Add a generic function to return the preemption string.
>   lib/dump_stack: Use preempt_model_str().
>   arm: Rely on generic printing of preemption model.
>   arm64: Rely on generic printing of preemption model.
>   powerpc: Rely on generic printing of preemption model.
>   s390: Rely on generic printing of preemption model.
>   x86: Rely on generic printing of preemption model.
>   xtensa: Rely on generic printing of preemption model.
>   tracing: Use preempt_model_str().

A meta request: please do not put periods into patch titles in this and 
future series...

Thanks,

	Ingo
