Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209168;
	b=RSl4X0faBZ9qfrNixW/8dcCQG+eD93uxS2Ix3cVguDlgXZNDLbGeHJE+mfYXIn+1uPdD
	 mZHY0JaN0XP23su6DkNWbhZkr4ytvzfxIheS9sgvP3QliKykwT+7idnhIHQj94FaaRWad
	 jkP7w7VDrwuikRw/PvMt3f1WLBJpeOKUJ8b82uesO8tiAJeDCr3yjHJkMPZ3loks8sSNr
	 CtFHwkjCg7Vtt6P+REpQ0KBs7+txyMWd0dYaxjF6Q/XfN0iB5pRxyN4ag+4GHn3fik01k
	 67wASCJeFAwUU+t7VOLx6vBzG/WGP9wBPKb/qiZ6xbik005HIGWiWA0Yj+3QpFSqLQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qcWoDU3Oj7R3gfFMS5s9nDJ8jfe2LiGqdzd+9pG4O+4=;
	b=UU8aX6/Su5CG1NKYwTha8GDhbdFXbyCa+GCoofQwQvHSjYXfMfGDqQhOLISBSFcrW+Tq
	 IUwz11KfKyaRRpr+m03HEbuwMSCPN6aXgDwmFq7hNX4vb39BB5tFQpjC4wVSPh9qv5xHJ
	 J02SObWTKzHnhpX8XKmkwDyFeD4gd7N1+595nDXHW+oGc0FTVE+kZUjDw8AH96N50RjTB
	 PkDdg3Uqexg47/T4HSvQMO5eFyymbzzsxX8+vQx/m5mIGsepvTFP7Dac3rHQDmWoaGxeL
	 UvliZ5GkRIMJC8+gZCBw+X6hUwayTniFcjrfPHX1py+1wBUsOAsGeQ0hDdg1av4+SSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqINUPU5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B1606A698;
	Fri, 20 Nov 2026 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqINUPU5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B6E1F000C6;
	Fri, 20 Nov 2026 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209168;
	bh=qcWoDU3Oj7R3gfFMS5s9nDJ8jfe2LiGqdzd+9pG4O+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqINUPU52WYYnVNVBIi/uUJ/Li0zkTYGuC7/qUE10FJ9QD488ckBBui8veKQrGusT
	 W4+MO9uQemQ5w7CrxmPAaA5PP0UwuOesLs60lcoh7aJFtYwwZ4Xd3rgo/2KRQt7WRj
	 4Q256rc0dYVD98o7eMTbLwm+72dFcg5eqmtGFjd8v1kQkKgiBUvKqS+9O6wuPk0be+
	 12SBdeKOa27LwEW2aOxQeIY/MqwqinaBQWi50jhDngCO1g9CuYePxUu4wSDxLD/wwF
	 yDAczLJh6wgFIBUm/NXKOI1Pj3dHXKhWYjqBd3V6mX+EGSMcmedfGuuc4TA/SspW+y
	 BAJXbynGVhsBQ==
Message-ID: <sashiko-outbox-226141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/40] selftests/sched: Test SCHED_DEADLINE
 bandwidth across a root domain rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <4bfaa652a0e1e4c92a628472be5bc3cefd29484d.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <4bfaa652a0e1e4c92a628472be5bc3cefd29484d.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:12:47 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/sched: missing sched_setaffinity() in
  deadline_rebuild_test
--

commit f6538c4af07769165daa29a5b3577ecba3fd01c9
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test SCHED_DEADLINE bandwidth across a root domain rebuild

This commit adds deadline_rebuild_test to verify that a SCHED_DEADLINE
task's remaining bandwidth before its 0-lag time is accounted properly
across root domain rebuilds and cpuset partition migrations.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_rebuild_test=
.c b/tools/testing/selftests/sched/deadline/deadline_rebuild_test.c
> new file mode 100644
> index 0000000000000..85b24b868da72
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_rebuild_test.c
[ ... ]
> +/*
> + * Pick the two highest online CPUs that are not isolated, for P and Q.
> + * Return the number of such CPUs.
> + */
> +static int pick_cpus(void)
> +{
> +	static char online[CPU_SETSIZE], isol[CPU_SETSIZE];
> +	char buf[4096];
> +	int cpu, n =3D 0;
> +
> +	if (read_file("/sys/devices/system/cpu/online", buf, sizeof(buf)))
> +		return 0;
> +	parse_cpulist(buf, online, CPU_SETSIZE);
> +	if (!read_file("/sys/devices/system/cpu/isolated", buf, sizeof(buf)))
> +		parse_cpulist(buf, isol, CPU_SETSIZE);
> +	cpu_p =3D cpu_q =3D -1;
> +	for (cpu =3D CPU_SETSIZE - 1; cpu >=3D 0; cpu--) {
> +		if (!online[cpu] || isol[cpu])
> +			continue;
> +		if (cpu_p < 0)
> +			cpu_p =3D cpu;
> +		else if (cpu_q < 0)
> +			cpu_q =3D cpu;
> +		n++;
> +	}
> +	return n;
> +}

[Severity: Low]
Should pick_cpus() or main() also call sched_setaffinity() to pin the test
process to the non-isolated online CPUs, as deadline_bw_test does?

On a system booted with isolcpus=3Ddomain, creating or removing partition
roots under the root cpuset resets tasks without a user affinity mask
(p->user_cpus_ptr) to all CPUs in the root cpuset, including the isolated
CPUs.  In test_move(), departing(NULL, SWITCHED_OUT, fd) can then run on
an isolated CPU in def_root_domain rather than the housekeeping root
domain, causing set_deadline() to either fail or test bandwidth departure
from the wrong root domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D5
