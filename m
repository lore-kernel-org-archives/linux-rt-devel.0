Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497596;
	b=REiG27724ArkjTFIWYg3s+/jOely9vBDZ2i6mEsSkQQhV7hH55Uh614psDtvq+e9Pxg8
	 6l/1+0pdAh91TxkvrVnhnoCOrEKt4eQvGwwylWpqDeIxIfC6znSuBTsQhfYLjBQyX0+BK
	 WckL/weKyzG8NcOjjrwIPYwzzGKiy9FTMz72NVWCIO0BQCcaJV0JPuo2aoG5gmFqZ8iGJ
	 lvZZthGbicSGcRopngppch00Jd+xzgA1HOQKU+W9FQSaz1o3ug12S4LVXF4ip3YnvCNJ4
	 UW9dg3rFWH6ZFJPEpTR1esacZlfdzzY+PjtbQRwCER5o2Zi5nd8unD4Nq5HlUahMnIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497596;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=veSJGotBoj+iimflxj3ND76JuZYK4ZPe8ia7VhEaFl0=;
	b=Ict4Rk0bXJZLhQ04/w8L33fVPhMpOTc+aM9mc7ocgNhkI0Gk1+1QuuW/n7jvw39vU1cy
	 zxMRH7iFZ49MhzjI8LI4CnE8EQpPMslXbGQv4gh4dum+TQ/3ATSyUZ6KzjW6kA/2JELaM
	 pEzUOVbOBDO3WtAkXiPnofraHT+F2duMAP8Rch/wtkiB4qsNTNrQyaeusDrHosbFzf8Kx
	 ekzXn8v1F3+RnArlbGZOYUm3GX/kTAnHP4/AtH1e80nD3jGFHi0XHByZF2MK97l688bro
	 jIETw57Z7amBPqeMek/i9YbSwgm/g0cu3nJ3/4TdS4bQhtzZO8LxMDxW9IFGqKuZiOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="U3OXNaD/";
	arc=none smtp.remote-ip=95.215.58.77
Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678E606A327
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 05:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B678E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U3OXNaD/
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dkx/rFg5tcdo0jyXwoP/INhxBquh8QPDDUXaK4cZ418=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795497593; v=1; x=1796102393;
 b=U3OXNaD/kdc3yAlSDT0YBZ12HUVeD7TppunrCCDcIDHDV8J68ggxCkc7zHyNgAnVd3a2a7E/
 9+pXntqw9MGZgp7JpEmk89Kd1kUT+hem2Ja2XcXsxjORT9f7Gtr3QfT1I2QgKQpD0XC8NcjSZpS
 xbDhw+b4s4E5buKGTJH5/h5Q=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 5ba68d8c69342137;
	Tue, 24 Nov 2026 05:19:53 +0000
X-Mizu-Trace-ID: 5ba68d8c69342137
X-Migadu-Flow: FLOW_OUT
Date: Mon, 23 Nov 2026 21:19:46 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, bpf@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Puranjay Mohan <puranjay@kernel.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf-next v2] cgroup/rstat: disable preemption in
 css_rstat_updated()
Message-ID: <20261124051658.GA555944@shakeel.butt@linux.dev>
References: <20261124031642.40616-1-kmehltretter@gmail.com>
 <c665ace5-dfd5-4fb7-abcc-7454f732fb36@linux.dev>
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
In-Reply-To: <c665ace5-dfd5-4fb7-abcc-7454f732fb36@linux.dev>

On Tue, Nov 24, 2026 at 01:03:04PM +0800, Jiayuan Chen wrote:
> 
> 
> On 11/24/26 11:16 AM, Karl Mehltretter wrote:
> > BPF programs can call css_rstat_updated() with preemption enabled.
> > The kfunc calls __css_rstat_updated(), which requires preemption to
> > be disabled while it queues an rstat update. A cgroup iterator can
> > hit the lockdep assertion on both RT and non-RT kernels. The
> > cgroup_hierarchical_stats selftest can also hit it on PREEMPT_RT:
> > spin_lock_irqsave() on trace_cgroup_path_lock leaves preemption and
> > interrupts enabled there.
> > 
> > Disable preemption in the BPF wrapper after validating the CPU and
> > before calling __css_rstat_updated().
> > 
> > Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
> > Reported-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > Closes: https://lore.kernel.org/r/20251119111402.153727-1-jiayuan.chen@linux.dev/
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> > ---
> > Assisted by an LLM.
> > 
> > v2 places the preemption guard in the kfunc as Alexei requested:
> > https://lore.kernel.org/r/DN26CP5BB6O7.23ALW6CZUBYSD@gmail.com/
> > Since 8817005efbdf split out the BPF-only wrapper, v2 does not add
> > preemption operations to the in-kernel callers discussed when Jiayuan
> > proposed the earlier kernel-side version in November 2025:
> > https://lore.kernel.org/r/20251121040655.89584-1-jiayuan.chen@linux.dev/
> > v1: https://lore.kernel.org/r/20261121082843.44614-1-kmehltretter@gmail.com/
> > 
> 
> I suggest you target cgroup-tree instread of bpf-tree if you need revise, because
> you only modified pure cgroup file.
> 
> Since your v2 does the same operation as my previous v1 which was denied
> by cgroup maintainer, I also suggest you wait their replies (
> As time goes by, situation can change).
> 
> I still insist on kernel-side modification just like this patch because we should
> prevent 'wrong' bpf code from triggering WARNING.
> 

After the commit 8817005efbdfd all the in-kernel usage has moved to
__css_rstat_updated(), so I think this patch is fine.

