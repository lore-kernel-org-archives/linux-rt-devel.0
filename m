Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD063FADF8;
	Tue, 26 May 2026 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814345; cv=none; b=MyAmFk/sWO7gKKufzyBZYJ83Ch+fGgkS9tnlCcAlCnkzTMZM4C9Sem9rYd1nfUgbF7qnphKEQDG3aUDbew6i4koliCtYGhUUmLhI0YcCTaID4l3DKrnX6ZWuf3HtoxfuenQzOZZvWojjFkRJuxUJvVWL0mseZwb8KLVInZGbFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814345; c=relaxed/simple;
	bh=b70iNpOAo4J1yd5gqLr3hNmrHnjVkz1gDv12JovZ6so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1V9yTvaVK+cAT7zGn4+1r3VQgePGzNAMx/Gw6P8VCr1PHcsY0ggb0SuXVkBlhFzDtIlbaEyQQF07oZBH/jVTIYX0JhjAukJXK8/oRBs6VTqt+Wmc+fUWQ/J91S31ALAtTJ89uGkRLUP+qkLK+HYoysMTt5a+KwGQigDujSMDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce3YhG1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce3YhG1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0541F000E9;
	Tue, 26 May 2026 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779814344;
	bh=iqZU0VSF4u3exzFmb0oOCc3SQ132DKj9diAAdClssVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ce3YhG1O2J0oru3Kpta03Xyl24U6CeF3FrqDEnNPAAo8F57X5JGvA4xtrefe9wSdG
	 FkEWdSronUB0iXZ5dAJllwKKbA/IrDQs5QLtvLSRjZlb7qjYkzMMnHHh/YInsv9UUF
	 o3f86Ls0FmSkeSp/gb/u5U6x/G5HHDcBZJYzHQP+hZ/zBOdmJ0MLCdvRsITF3LdxIM
	 /LUYz0Qyb3W7o3CpplGKMQN9x1ZEGNyZ5/qFm1peqWvDSAmWoWDKdbSo+zeXd0CQjE
	 5V5A/8flfwnbVBOkMO6wtblSRoV2RR+bWAoVNCnVsi8V75l+tUHTPLRo6fhlgbX3i/
	 30SpQDMZjCrhw==
Date: Tue, 26 May 2026 17:52:18 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] l2tp: use refcount_inc_not_zero in
 l2tp_session_get_by_ifname
Message-ID: <20260526165218.GM1506108@horms.kernel.org>
References: <20260523023423.2568972-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523023423.2568972-1-michael.bommarito@gmail.com>

On Fri, May 22, 2026 at 10:34:23PM -0400, Michael Bommarito wrote:
> A reader in l2tp_session_get_by_ifname() can return a pointer to a
> session whose refcount has reached zero. The getter takes its
> reference with plain refcount_inc(), but every other session getter
> in the same file (l2tp_v2_session_get, l2tp_v3_session_get, and the
> corresponding _get_next variants) uses refcount_inc_not_zero()
> because the IDR/RCU lookup can race with refcount_dec_and_test() ->
> l2tp_session_free() -> kfree_rcu(). The ifname getter is the only
> outlier; the inconsistency was raised on-list after 979c017803c4
> ("l2tp: use list_del_rcu in l2tp_session_unhash").
> 
> A reader inside rcu_read_lock_bh() that matches session->ifname can
> be preempted between the strcmp() and the refcount_inc(). If the
> last reference drops on another CPU in that window, the reader's
> refcount_inc() runs on a counter that has reached zero. refcount_t
> catches the addition-on-zero, prints "refcount_t: addition on 0;
> use-after-free", saturates the counter, and returns the saturated
> pointer to the caller. Session memory is held live by the in-flight
> RCU read section, but the kfree_rcu() callback queued from
> l2tp_session_free() will free it once the grace period closes; a
> caller that dereferences the returned session past that point hits
> a slab-use-after-free. On PREEMPT_RT local_bh_disable() is a per-CPU
> sleeping lock and the preemption window is real; on stock PREEMPT
> kernels local_bh_disable() is a preempt_count increment that closes
> the cross-CPU race in practice (see below).
> 
> Use refcount_inc_not_zero() and continue the list walk on failure,
> matching the other session getters in the file. The ifname getter
> is the only session getter in net/l2tp/ that still uses the bare
> refcount_inc() pattern; this change restores file-internal
> consistency. The success path is unchanged.
> 
> Fixes: abe7a1a7d0b6 ("l2tp: improve tunnel/session refcount helpers")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

