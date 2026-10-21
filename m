Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555399;
	b=VBy9ufuVe+DvAoJDYWHeNegauDXlpKhHCn1dpCZwgF3IIsvQQREK8jKSOVJ2JANpI+8o
	 II6rzo/PoBqUeT8PzUge28g5Ho9S/bSwYJXAS55aDHlWu2lJSRgS3RAEe2z+tlvGWPIBD
	 W2i93Pjmh/9/3aWSZh0/f61nJ7+14iOksC39heR55PBTLGcB//XUuMGilxZ4Yo7kcvutV
	 JjqQ2hCm5a40JWs0O5fyx4xrD4ZE2GOKhPyTM/JiY0GtrfCltXf9XGlPu2UdWonQ4bY6F
	 bET+Btbs/63iJl4+MBw9Jr/sBXAa6wKWSZnBiLnsVTz1VmlIp+ksR0mxVuJmb0ftgvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555399;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=R/vjUdN7l6MMbVXVqQIOOhrZyiP+lwy/sbzpp28dRMQ=;
	b=AHQewEV61tsdvctsngHxYQa5cDXrEk6mPeWN422z6Xqs6Pq67P6tAdSR3ZTz5AvS309i
	 GqqrLwx9hnxhBs+qpjltRlx2+ChMLsQUw0N3KKKPB/9drD8aFTXAqjbt1HIahZIeIs/Ul
	 5FgwSWkWb4KsF0YcG6OK2IOKftPFitkSOHhGsYGhCdCv4NT1CUnMM9D5w+zDq1zgw5uFI
	 cAUn6X80iYSvLFBjT1/H8NuK7hkCTmMCorJkWeNKrtkOF9taJjCbahIT1gAFg3rSvpT7o
	 mxwdVKKtHIk7aFCH30YSiDiL1gNduY4dPi3eDfi2pZKZ5UURRBRwb3vTC/+JJtbNpjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhjAvGEP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21574606A319;
	Wed, 21 Oct 2026 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhjAvGEP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB511F000C9;
	Wed, 21 Oct 2026 04:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792555398;
	bh=R/vjUdN7l6MMbVXVqQIOOhrZyiP+lwy/sbzpp28dRMQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=PhjAvGEPJDvNbV+BvdfgJHIv5DCumkZua0q9FAzCiMyGMwCJrVtYAOzpgzBEfnJg2
	 RND2Zytp6F0E3/o8nf2a+aVBSVsRVKa/15+BRv9L1Hau0ZULIFMqqOZ98HmSL2zebc
	 maBL4WU1Oh270/xRztb7EzGFUCN+ujtI/FsPLnF5xiqafuX3ScyzXdMyEHGpbbz7QB
	 OYMy9NetTBKnRey8UVIhSutjMQLv7nVDPq0gSdU1jgRRAFHViWA4IN/wvKhR5WWMeH
	 T14ko9AQZgb4zyj+vqzZHJxFDT5LHXx17MJ+s4fV1OUG2V5S3Mb+59vyk+i5N4cty/
	 fuv9AgngZgXSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59500CE09E8; Tue, 20 Oct 2026 21:03:18 -0700 (PDT)
Date: Tue, 20 Oct 2026 21:03:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH] rcu: Print CPU that preempted stalled reader wants to
 run on
Message-ID: <22d0d56c-6cef-47d7-a923-1d888e224b58@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
 <7a827d0a-1a69-4be6-8b69-9a9769b182b7@paulmck-laptop>
 <0d0974b0-5235-4764-abad-0a665c27a1d0@amd.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0974b0-5235-4764-abad-0a665c27a1d0@amd.com>

On Wed, Oct 21, 2026 at 09:11:02AM +0530, K Prateek Nayak wrote:
> Hello Paul,
> 
> On 10/20/2026 2:17 AM, Paul E. McKenney wrote:
> > This commit defines a cpu_curr_snapshot_rcu() function that invokes
> > rcu_dereference_all(cpu_curr()) to determine which task is currently
> > running on the specified CPU.  The RCU CPU stall warning then uses this
> > new function in order to print the task that has preempted the stalled
> > task (the stalled task being the one that is in an RCU read-side critical
> > section, thus preventing the current RCU grace period from completing).
> > This modified stall-warning message also includes the CPU, along with
> > an exclamation mark ("!") after the CPU number if that CPU is currently
> > offline.
> > 
> > This is a potential step towards allowing people (or LLMs, for that
> > matter) locate any tasks that might be preventing the preempted RCU
> > reader task from running.
> > 
> > Adding a get_task_struct() for the currently running task would be a
> > bug because we are not in a position to prevent that task from exiting.
> > Yes, yes, because interrupts are disabled throughout, the corresponding
> > task_struct structure cannot be freed, but following sequence of events
> > is all too possible:
> > 
> > o	The check_slow_task() function places a pointer to the task_struct
> > 	structure in its local variable "th".
> > 
> > o	The corresponding task exits, reducing its task_struct structure's
> > 	->usage to zero.  The task_struct structure is therefore passed
> > 	to call_rcu().
> > 
> > o	The check_slow_task() function invokes get_task_struct(th),
> > 	setting th->usage to one.
> > 
> > o	The rcu_print_task_stall() function invokes put_task_struct(),
> > 	again reducing ->usage to zero, and again passing the task
> > 	struct to call_rcu().  This results in either double-call_rcu()
> > 	or use-after-free, depending on when the RCU grace period for
> > 	the first call_rcu() completes.  Both outcomes are bad.
> > 
> > This commit therefore relies solely on disabled interrupts acting as
> > an implicit RCU read-side critical section that prevents all of the
> > task_struct structures from being freed, thus avoiding the need for
> > get_task_struct().
> > 
> > The original get_task_struct() calls in rcu_print_task_stall() on the
> > tasks on the ->blkd_tasks list are safe because those tasks cannot exit
> > without first acquiring the rcu_node ->lock that this code already holds
> > (because these tasks must remove themselves from the ->blkd_tasks list).
> > But it is better to be consistent and rely on RCU in both cases.
> > These pre-existing get_task_struct() and put_task_struct() calls are
> > therefore removed.
> > 
> > [ paulmck: Apply feedback from K Prateek Nayak and Peter Zijlstra. ]
> > [ paulmck: Apply feedback from Steven Rostedt. ]
> > 
> > Link: https://lore.kernel.org/all/a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop/
> > Link: https://lore.kernel.org/all/e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop/
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> 
> I tested this on your old dev branch on top of commit 5433117c67f0 ("EXP
> rcutorture: Disable RCU priority boost testing on non-TREE03 scenarios")
> and the idle state during stalls are reported correctly.
> 
> Feel free to include:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thank you, and I will apply this on my next rebase.

> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 8b3d47a325cca..3606e5a2cec32 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2532,3 +2532,5 @@ extern void migrate_enable(void);
> >  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
> >  
> >  #endif
> > +
> > +struct task_struct *cpu_curr_snapshot_rcu(int cpu);
> 
> nit.
> 
> I think this and the function definition in core.c can go right after
> cpu_curr_snapshot() in respective files to keep the related bits
> together.

Excellent idea, especially given that its current location is getting me
merge conflicts when I test with the -next tree.  Done!

							Thanx, Paul
