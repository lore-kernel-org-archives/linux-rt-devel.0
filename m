Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150337F732
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079132; cv=none; b=M1aTkKy4LUZEOGUrMQ0F5qrSX7Cup48Zw0dc88P8alX50hqOFcQyrLIbEFdMgnNFw3v/AwGwMgfQOvP/l2g1A9izuSkpJ4/wfqKTXRdyJlYmgfxhI63bq2aG0o9yHC/QdhQUmVGiEsAU424nXVtTmv6++jZOf/OiaNGtr4E4UY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079132; c=relaxed/simple;
	bh=JvOJyOg54eQi6xbjkDVp9UMSUWhjgZzCvD/d5S1k3Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwBDWlKMOUaH+V34TieUtDggcUbviATx77ZXKMsvGzv+cmoCuxYsVpd0bZyY6851F33NtVnLUQfd0Y4DyKF4u3yILrjvW6Eqeky63rvb1V5N4aOqWt4VAXYaHy5J/tyPTClPYkGZyziQo/w4Js66UnKQRrgTOnxGCCFFy9URdp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxMoh0MM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxMoh0MM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0781F000C4;
	Thu, 15 Oct 2026 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792079123;
	bh=6jqq/tSJUolsx1RzdOs0SdHfwqnFDSCruVH1Cx9bFws=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=IxMoh0MM7zWs5+H7kiBOwuzdAEy2mcXG9H9DWA0ydZkNsTTWo7bTu47NkRU8XXjN9
	 egSNJygaKQRfjC8gf8Y3r+IoMiKx8UE3YquHeTBUbU/QvVq5bBnR0bYTkh3ODaKcEn
	 45hXMpClkTKFKrh3AqyWVVI/cuGa+lr95QVRs8ycFP+V4/uf1b29U4jb4pr1VhYycM
	 HRUZgdYezOrmGdtvFe2FMMkHHTpTTVgzsShhRlLqv44/R/wu2GwwwQXmvDoibh/jVj
	 x7kv24O9gpM7QXpQmsQ0iVF2jWW+rEafP4neTczNyojlCBTzQ4zqB0CKJ4UzNu530i
	 ePbTarceUH2jQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8DF9CCE0469; Thu, 15 Oct 2026 08:45:23 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:45:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Clark Williams <clrkwllms@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <19ab5066-b035-49ed-9b80-86fe67852174@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
 <atDw3O5RILsTE1mn@demetrius>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atDw3O5RILsTE1mn@demetrius>

On Thu, Oct 15, 2026 at 10:27:24AM -0500, Clark Williams wrote:
> On Tue, Oct 13, 2026 at 05:41:41PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > While chasing an "interesting" bug [1], I modified the RCU CPU
> > stall-warning code so that when a task (as opposed to a CPU) is
> > blocking the grace period due to being preempted, the stall-warning
> > message includes the task that is currently running on the CPU that the
> > preempted task wants to run on.  (In the case of the "interesting" bug,
> > I kid you not, that CPU was idle.)
> > 
> > Would this stall-warning addition be useful for PREEMPT_RT users?
> > 
> > If it is not useful, I am going to keep it out of tree.  Something about
> > it needing a way to dig into scheduler internals.  ;-)
> > 
> > But if you want it, please let me know.
> > 
> > 							Thanx, Paul
> > 
> > [1] https://lore.kernel.org/all/8fa7f795-518c-4507-b684-60b0c1cac2c5@paulmck-laptop/
> > 
> 
> Paul,
> 
> While RCU isn't one of the common reasons for a latency spike, if it
> *is*, then it's not one that's easily tracked down.  For that reason I'm
> in favor of using your patch. 
> 
> That said, if it's going to be a pain to maintain, I can live without it. 

No problem maintaining it, just a small up-front cost of convincing the
scheduler guys to give me access to cpu_curr() or some other API that
allows RCU to find out what is currently running on the CPU that a given
task is trying to run on.

Given that it would be helpful to you, that is enough to motivate me to
go hassle the scheduler guys.  ;-)

							Thanx, Paul
