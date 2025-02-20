Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD012FC23
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048788; cv=none; b=dJVmw9Qx4XK4C8/NlikRToNlBXMNKZQVkE8pl88s1prj8OJXtpVJpwiThglniqpI8VKeGRudWQ6nQAfvlRsoMcssixVlQzcXtk+Gh3SxataH/il9/jr2AWR2+X1PdvZ0GAEcWQ3ntDKBu3xN6/ZsZc9F/WCk1QnvoRfrUJjnG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048788; c=relaxed/simple;
	bh=24RqXPBvQEJBvp2360+sbc8vRtULjiYxw1sqZs315sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuIF/P58je44wDJAuS00C7ChX7J7ssqAYvupty/++CUcVLFBCQrGW6R7f93bbIRX2qrpuPAqTLqJ8rHdaPfaRDfKr5SwGlBN+hivE33oCCbK5G8CZt67aMYMCFhjlbdhtO67Y6xreNHUMb0mUyP/fKqPUZUfEB9uyOfJ+I4s8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EU0ZpEwf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EU0ZpEwf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740048786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybUAvCvDmkVaulvrtcxg4fJ6mm5VHpReOL6J0mN8mco=;
	b=EU0ZpEwfXATPBq4xRyON+ufi+6iZkddv32ajs+lZ/vbTVv4uLSIBY/osNKpN6qAsSp/GOw
	mP+U2tfvYDYYWa2yv4VSaFhNF+qaAdynpdJoNVBHTMBB0VS3lgU/rRa9a0c9ZciN3nk3ZG
	NOl8tIslwgBHb5XKHfM6rTwBKICH3qU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-LNuSLmFSOaWLOP7C8iEy8A-1; Thu,
 20 Feb 2025 05:53:01 -0500
X-MC-Unique: LNuSLmFSOaWLOP7C8iEy8A-1
X-Mimecast-MFC-AGG-ID: LNuSLmFSOaWLOP7C8iEy8A_1740048780
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1A81180087A;
	Thu, 20 Feb 2025 10:52:59 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id ACA311955BCB;
	Thu, 20 Feb 2025 10:52:53 +0000 (UTC)
Date: Thu, 20 Feb 2025 07:52:51 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	clrkwllms@kernel.org, jgarzik@redhat.com, yuma@redhat.com, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <rr74uiqgjqo4wwvrn4ealkojdicnpmpyvaz4glzfgvbgwze5ym@qkaeflpyqqox>
References: <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
 <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de>
 <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
 <20250219102916.78b64ee4@gandalf.local.home>
 <20250219103006.6a1ef14d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219103006.6a1ef14d@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Feb 19, 2025 at 10:30:06AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2025 10:29:16 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > After adding the probes by perf, what's the content of the format files for them?
> 
> Also, what's in:
> 
>   /sys/kernel/tracing/dynamic_events
> 
>  ?

$ cat /sys/kernel/tracing/dynamic_events
p:probe/igbvf_reset_L14 igbvf:igbvf_reset+98
p:probe/igbvf_reset_L16 igbvf:igbvf_reset+123

> 
> -- Steve
> 

