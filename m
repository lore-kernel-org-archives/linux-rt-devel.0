Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208047;
	b=tO/UuLhNGFZ7LWF4Q46GzRMPpxM1NgYptLrYAFH75ggf2wZafkyVCdNQQgM9boZ31yVM
	 sAhOqQ4GDSr7lqtD17Wpyux2jB4Pm6UlEbzKlS5l9jrzdg3hWkMQ6mICn/SbUvSGonzDP
	 Oct9NZP5xPtGrX8qvvoyBYZ5lHFcPCp8DewIPZ3MMbdDQtMaPFFlQ9Iq/MevL8PhI01Ml
	 9omT7Q6Dcu7Qdts0hK4unik3XqqxjwgHM51jue8atillEH97JxLuG84zhQq/VnLV4p0bJ
	 A8s20n6tgTlYCkVX7DuruwSk5CMQw3A4wVMrNOSceGq9dpUKyIv02x7GPbK+L1yjwSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208047;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=llJnKzPoTZyGmg3Zg2y5fd8HX957hF39RVHqH3K3+cg=;
	b=2/wrY8msE0E1eFj0W33qeCUmxONzU8AydVqzm0EjTYhToTNvGzYJl2F2GgBPWPhKCatI
	 Km2rTnFW9ua+bJYU6DllVgUI010b1MYqdXxzXalp8XlFV9+D5kBd4mEf5Bq5DK30S5HsE
	 sJd2wMQGrA5TYQj3F+AOsJ91zLLy0W6aIp2eMFKvChAva3T2G0tvVGaXBBShBQxVoz7c/
	 LRGqBoFArpGLbP4oVvx3h/Rzwm/K4jSM7e00MEqgM74sMCU2ryD5PY5ne+O+dxUn+Am4a
	 d20xTAAU5yQ5pQWqiWkCmo1X++8IXMZmJaQiwmLHHzRfWHASZJaF+D+825d23gOuwLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/5/dxf/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0A606A6B3;
	Fri, 20 Nov 2026 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/5/dxf/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEB61F000D1;
	Fri, 20 Nov 2026 20:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795208047;
	bh=llJnKzPoTZyGmg3Zg2y5fd8HX957hF39RVHqH3K3+cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/5/dxf/xAqtgRu612QrTb/e7QUwFLUQq1oW2ctoeSZdD9lcaDER023G5+GR1J2bb
	 ucDer/cck/S3I0WRZM41BbsK4hFGuDUJhWzt5FgvmG3paZ1Xn0TQINsvppxMWD8kxn
	 fbx00NLkLQ5mhrXdmsSHpiE07jqGJY8Q6iV+5cagvu9/bMb1V5dlvQUj7EVqbLj2hL
	 8G8/pMYcPxa/m1IPe92ZH7g2Xvb9gUWUUwo7u4jCJqIhnSSPpnpck1bs2JHrWMWgbC
	 +PpsnemE/trc3ijcHsmkKDDDLTje5cHWP030ubEkE2ax8NyTtgSXZ/soF89weeLagA
	 qCClvNJzgu4RQ==
Message-ID: <sashiko-outbox-226108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 18/40] selftests/sched: Test the root domain of a
 task in deadline_bw_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <a0e1f11b56620173bb409d66ade1f44ffd29d519.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <a0e1f11b56620173bb409d66ade1f44ffd29d519.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:54:06 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] selftests/sched: missing no_hp flag for
  partition_grows_child_valid()
- [Low] selftests/sched: inverted tell flag in
  partition_grows_child_valid()
- [Low] selftests/sched: missing cpu_hotpluggable() check in
  hotplug_top_last_refused()
--

commit 31c2701ec79ac71f9d7072a6b7c9ae3a844ce21e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test the root domain of a task in deadline_bw_test

This commit adds 28 test cases to deadline_bw_test covering root domain
bandwidth accounting across CPU hotplug, cpuset partition changes, and
isolated CPUs.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> index 0b53b64c7b3a2..7b0a3f2fb12b8 100644
> --- a/tools/testing/selftests/sched/deadline/deadline_bw_test.c
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> @@ -7144,6 +7695,1779 @@ static int move_back_cpu_offline(void)

[ ... ]

> +static int partition_grows_child_valid(void)
> +{

[ ... ]

> +	snprintf(buf, sizeof(buf), "%d,%d", a, b);
> +	err =3D write_file(cs_b, "cpuset.cpus", buf);
> +	if (err) {
> +		ksft_print_msg("B cannot get CPUs %s: %s\n", buf, strerror(-err));
> +		goto out;
> +	}
> +	if (!partition_has(cs_c, "root", 1) || partition_has(cs_c, "invalid", 1=
))
> +		goto out;

[Severity: Low]
Should the second call pass 0 for tell: partition_has(cs_c, "invalid", 0)?

partition_has() prints cpuset.cpus.partition when the substring is absent
and tell is non-zero.  Passing 1 here logs a message on every passing run
when "invalid" is absent, and stays silent when cs_c fails by remaining
"root invalid (...)".

[ ... ]

> +static int hotplug_top_last_refused(void)
> +{
> +	int i, n =3D 0, err, ret =3D KSFT_SKIP, x =3D top_cpu(1), x_off =3D 0;
> +	char buf[256], cpus[1024], path[PATH_MAX + 32];
> +	int go[2] =3D { -1, -1 }, ack[2] =3D { -1, -1 };
> +	pid_t pid =3D -1;
> +	cpu_set_t all;
> +	char c;
> +
> +	if (ncpus < 3 || cs_setup())
> +		return KSFT_SKIP;

[Severity: Low]
Should this also skip when !cpu_hotpluggable(x)?

main() sets hp_cpu if any housekeeping CPU can go offline, which does not
guarantee that top_cpu(1) specifically is hotpluggable.  If top_cpu(1)
cannot go offline while another housekeeping CPU can, cpu_online(x, 0)
later in this test fails instead of skipping.

[ ... ]

> @@ -7960,8 +10284,36 @@ static const struct hp_case {

[ ... ]

> +	{ "hotplug_sibling_partition_refused", hotplug_sibling_partition_refuse=
d },
> +	{ "hotplug_top_last_refused", hotplug_top_last_refused },
> +	{ "partition_grows_child_valid", partition_grows_child_valid },
> +	{ "hotplug_isolated_partition_falls_back", hotplug_isolated_partition_f=
alls_back },
> +	{ "partition_takes_fallback_refused", partition_takes_fallback_refused,=
 1 },

[Severity: Low]
Should the partition_grows_child_valid entry set no_hp to 1?

partition_grows_child_valid() does not take any CPU offline and the file
header lists it among the ten cases in hp_cases[] that still run when no
CPU can go offline, but without the trailing 1 initializer main() skips it
whenever hp_cpu < 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D18
