Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692E2459DC;
	Fri, 29 Aug 2025 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496074; cv=none; b=uWITmJ8rESBxxlSEYftrHzDHKt/+Nolmg34a9DtyjZGvrke2Fkurq/vfWzN9wU9bLWQ0mPyYdS/30yQFbP08Z5jCYERKcYcnIBGgHfmK66UicnV+3RJb/FFhkwdWsDaAfRacAsej4rv5t/QymfJgCH2+vq6+/bLSmqBTwUzV2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496074; c=relaxed/simple;
	bh=+w9IkauBo7cCrLno5CGhc+wFecYIkjUGCI33AwCLl1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxdGGKEpH1ZZ2Tq9OlPgYSS0TTa1TEzx8elWGkyKuqi+wk8/qLXMMu9cALobT+cFTnzXKYsxwddlptZmmEqebZWRkvMSEa9jF4QRiwg0Dx20EaFiDr/zQux3pFHQwCSYYGvWPH7kYDqvQhrbIkEHASnINS7ThQZbYlUIUzJOSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwAneyXr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwAneyXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0F0C4CEF0;
	Fri, 29 Aug 2025 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756496072;
	bh=+w9IkauBo7cCrLno5CGhc+wFecYIkjUGCI33AwCLl1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwAneyXrbjTglb77Jlm1LivVok9uTtra8zlDYIRPlvCoYO/pFigepdh249SWSQF8c
	 wfcwYYNBTK9bEaTVXl92mlUFq66F0AjKNDbmwr3VsOKRNMA5XglUiyAD7YdIwdRhA7
	 aTiU9geLUb4y1LE2h1HKwKRRYnLBomrFLNc56Az5wTz8eRaXy9KW9pWV2fbWo4ZI4l
	 Tf/OaiR+d5pKuRAapMJe6jo9n46JTAkHx1LsawhqMPOp+mLworCz/QsBQFkuKNy/pl
	 EZFrAYJ+mRRe12j/XsInY3n8Ygr7Zo+SMNzv5RcOMDqIdY2Y4+LuWUsDSoljAjLY4R
	 dJzhkkEj9Q+BA==
Date: Fri, 29 Aug 2025 09:34:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <aLIAx5Cf6mLC2Y_A@slm.duckdns.org>
References: <20250820103657.vDuDuLx6@linutronix.de>
 <20250820105518.Yf36NzJd@linutronix.de>
 <aKYltdkLBRZJF0Ok@slm.duckdns.org>
 <20250821092827.zcFpdnNy@linutronix.de>
 <aKdTEkK5MBz_Fj47@slm.duckdns.org>
 <20250822094812.L4hiquhY@linutronix.de>
 <aKix80fycymWz3Mh@slm.duckdns.org>
 <20250826154942.BcGs2_U5@linutronix.de>
 <aK3gbywOkrksPQeV@slm.duckdns.org>
 <20250828160455.4dxzTug1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828160455.4dxzTug1@linutronix.de>

Hello, Sebastian.

On Thu, Aug 28, 2025 at 06:04:55PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-08-26 06:27:27 [-1000], Tejun Heo wrote:
> > Oh yeah, that makes a lot of sense to me - splitting it out into something
> > which is named explicitly to discourage further usages.
> 
> I am a bit lost now. Do you intend to apply the patch and we came up
> with the bh-canceling-from-bh API later on or what is the plan?

I'd much prefer if the end result is that the busy waiting is a separate
API. Whether that's done in a single patch or incremental patches doesn't
really matter.

Thanks.

-- 
tejun
