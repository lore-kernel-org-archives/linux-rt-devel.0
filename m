Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858568;
	b=Iys0lLICrivgFGVaqKP7/tJ/gxOk4UuZIvTkbuOVRhngTcsds3B10CLF3Iu5PBhhsKlr
	 NnVhKhiqw5ggenoL66HbGMy/i/tjYTugd5jcf6abUNN7Z5y77sB0rbCLsW5W5Wi63GDhY
	 r7AfmaRL9Hw+dOkiIAVY51hNvDrJXnl2kqomKhDIf42w3pj2hOBxukwXOwAsy0WT5Cq3Q
	 dmcvFwaroAQYLD26wLVGxa3nNJm9cqT2BBj/gpJnkvD4qCpY9Vmb3dkpYT+SS4eYM5dh6
	 5iGENhqd3Vb1z+UYkWeVaU2XzCm1bAb/5WrELKbXQw3HWlZm8WCRU89MfiXXr9KeTDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N7V/LQp4s4UHS59ZWmF/9tR9RD0NtNJ6Gyly7akEEoA=;
	b=eCepUYo0ztLX1l1Eq8JKN2Z2q5U+MqKn9mdWiK3phRMqsKDDOPEUTUEmuNu4qSOFdI8v
	 QMClb2SOgk7ZjOwRR1V7CQ6dXmqx0roMbRh60HHd71F5D3iznKQOPbEoYvwEDNRVRK2Xd
	 05el60dBPgCezFfHJ7NlUQCMUVpdXVxE6PclV2RERMuaIv6OqW2YNZ8WjFxoiD50TpwkL
	 iuWELahqRMeSlUr4lmKRixV7oS2nXpZDk48JN/cI3zA1ZEFfv0fY3h+TQGRIZaYKq7jaV
	 ncyiNF4FJ2xRNxlQihSxDjh6XA4hKT8hG/eP4JNwBh8Y9SEvpXthAusHIhDHvUIiOag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lgzr+t66;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0A606A322;
	Mon, 16 Nov 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lgzr+t66
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A861F000C4;
	Mon, 16 Nov 2026 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858567;
	bh=N7V/LQp4s4UHS59ZWmF/9tR9RD0NtNJ6Gyly7akEEoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lgzr+t66Asp7CgWJkhJKR3Hsu0CRQYeaej+KBh8FpIAclnsWe352tFdLHsbVox7AU
	 xPiLGDLw8FSI+ri3HgmU+R78M70DE2qq/UAEwg+/CyVi9AsXsMV4Z2ZmkMBxHSxLyx
	 Au6ydOaefAKf2GyCa9/NGsQpKyJ4aG/ZONs1qtQVVVs7BSBuF09xUKGkA2aqv5kLeP
	 Q8CQZ+eqdL9yXnpB01Cxl22a0jKQNSLZZ2yV1H/nEJGf/Dw9kGE+Nyf5pa/Wl7kvUd
	 LSYkj5PQ7Hs58yqNWnaWsPN9NZLLcicpG/FrO3aXmuSp7Bjmn6DlyNJ5qksK/SWNR0
	 6N5O+CvI+/Uxw==
Message-ID: <sashiko-outbox-217617@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 37/37] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-38-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-38-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:49:26 +0000
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
- [Low] selftests/sched: unconditional cpu_up() and hotplug check in
  fallback_case()
--

commit a082e176a7ad72cb248a92c19ae446e62c656620
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Add a test of SCHED_DEADLINE bandwidth accounting

This commit adds deadline_bw_test to test SCHED_DEADLINE bandwidth
accounting across priority inheritance, parameter changes, cpuset moves,
deaths, yields, runtime overruns, reclaiming, fair servers, and CPU
hotplug.

Link: https://github.com/jlelli/sched-deadline-tests

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> new file mode 100644
> index 0000000000000..19c61a3a95296
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> +static int fallback_case(enum fb_mode mode)
> +{
> +	int in_b =3D mode =3D=3D FB_LAST_H || mode =3D=3D FB_PART_H || mode =3D=
=3D FB_STAY_K;
> +	int off_cpu;
> +	int on_h =3D mode =3D=3D FB_ON_H || mode =3D=3D FB_MASK_H || in_b;
> +	int no_offline =3D mode =3D=3D FB_MASK_H || mode =3D=3D FB_LAST_H || mo=
de =3D=3D FB_PART_H;
> +	char cg_q[PATH_MAX];
> +	int on_i1 =3D mode =3D=3D FB_ON_I1;
> +	char cg_b[PATH_MAX], cg_c[PATH_MAX], path[PATH_MAX + 32], buf[256], one=
[16];
> +	long long def0, hk0, def_off =3D 0, hk_off =3D 0, def_ref, hk_ref, def,=
 hk, bw;
> +	int fd[2], ret =3D KSFT_SKIP, added =3D 0, made =3D 0, w, at, err;
> +	pid_t pid =3D -1;
> +
> +	if (!root[0] || fallback_cpus(!no_offline)) {
> +		ksft_print_msg("needs isolcpus=3Ddomain: 2 isolated, 2 housekeeping CP=
Us%s\n",
> +			       no_offline ? "" : ", CPU hotplug");
> +		return KSFT_SKIP;
> +	}
> +	off_cpu =3D mode =3D=3D FB_STAY_K ? fb_h : fb_i1;
> +	if ((mode =3D=3D FB_LAST_H || mode =3D=3D FB_STAY_K) && !cpu_hotpluggab=
le(fb_h)) {
> +		ksft_print_msg("CPU %d cannot go offline\n", fb_h);
> +		return KSFT_SKIP;
> +	}

[ ... ]

> +	reap(pid);
> +	pid =3D -1;
> +	sleep_ns(3 * PERIOD);
> +	def =3D total_bw_of(fb_i2);
> +	hk =3D total_bw_of(fb_k);
> +	if (def !=3D def_ref || hk !=3D hk_ref) {
> +		ksft_print_msg("task gone: total_bw %lld, %lld, not %lld, %lld\n",
> +			       def, hk, def_ref, hk_ref);
> +		ret =3D KSFT_FAIL;
> +	}
> +out_up:
> +	reap(pid);
> +	cpu_up(off_cpu);
> +	pid =3D -1;

[Severity: Low]
Should cpu_up(off_cpu) at out_up be guarded by !no_offline?

For FB_MASK_H, FB_LAST_H, and FB_PART_H, off_cpu is never taken offline
(and mask_out_refused and partition_takes_refused have no_hp =3D 1), so
falling through to out_up attempts to write to the sysfs online file of
fb_i1 and logs an error when fb_i1 is not hotpluggable.

Also, for FB_STAY_K, off_cpu is fb_h rather than fb_i1, but passing
!no_offline to fallback_cpus() requires an isolated CPU to be
hotpluggable and skips hotplug_keeps_root_domain if neither isolated CPU
supports hotplug.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D37
