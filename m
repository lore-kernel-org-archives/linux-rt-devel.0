Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795818;
	b=2ecXH2D9YgtSOe2F/tbm1WsJ6B4oTeroQ0HVNtYXFTUI8iQhl4w1e2uoWdJa7NH8ClMl
	 i6K1Ehd8kotgnssXVmMg0VcM0C7zIZpPR1MMcnKvGHUt86f5GXqYSDIK2nds1HVbYUCTz
	 9YoEMesHsW5w/3+BbUg3wIsfUI9qr2JmLgEngAd4CupR9minvPsKj3mAK6fAdHlkzyzx9
	 kjf6DBQesZylumNplpdStPLiXkMwVW0NI8G4Auxjj52S1kXGDquyP12YVhlTa156SB8Al
	 E05UoFHSNfMN1PHE10JoXxsM44XoX0HuDsH8rvvdO/6/XZ+EJbu8tFPVcY9E2nZug0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795818;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ysjzaGfyQv2jqsZ99fyhOe4MrbAd+SNTztSkbg/92so=;
	b=QQpsvt5d8KUwKJC3Y0q2TKcDmH9iInwr64HEwfWEuI/XrwGxAs9/hBjrIvfw3+a8ZyA9
	 jigFXJiV2oqVNCFDp/dXKCVj5beFaj7/tciyQoCVle87t9TdZbERKZnDN8j+s3aqhSoYk
	 U1oTMq1lFOl6+PdxxbzqVOJv9eE45Cjn8pvqb6DOOJy/P9g9fp/sfiVD16N320TVMkp9u
	 0rFFWEK4AtwpoylSlphndbj2Dfb13tspP+vzaRbGsdebVK382mSMZMUGh06DwIjmKY20u
	 F7ubWEQjcvyhG02jmVNJqXuz4HXjnMNOioMP+GumCykMJMmt0iqWs2Gpz9ooCDJKWgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVbnTWvp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42B606A338;
	Fri, 27 Nov 2026 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVbnTWvp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C421F00929;
	Fri, 27 Nov 2026 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795818;
	bh=ysjzaGfyQv2jqsZ99fyhOe4MrbAd+SNTztSkbg/92so=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVbnTWvp4ZBjjYOUhvdan7q4yV+dfy1U9EhcRkEv3WvQhecWV/b4UL3VgbOTUsCBW
	 ls0mL7YMGK7P0d03iChPKXw2h34eTxFzEdg2ApVaymLZ7DoX3o1dJyM+5Q9DimQdZJ
	 +0U2w0dpVVhT+bcQtZTK5YDK11bdFTtckILxKtIlI3mowlFIaMIYIZ9V2jvvoKcrYA
	 EXUW/AY59iVAdoJrlX5M9xsXKFhuFqHXsuTJTOaSYDAg2OGVDP9CUO1K8V3sR4W3J5
	 rqZAf5UlOeQ5XafF7Ty0z1ipTqNr9qMeWG6ePxWyxhKGpU5LwxZ4uR9ZQuPeh+0ryA
	 6jv9uzFOfPkKA==
Message-ID: <sashiko-outbox-237842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 18/43] selftests/sched: Test the root domain of a
 task in deadline_bw_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <bd056b300844440d73b5b27b5d36d1b9491fa0e3.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <bd056b300844440d73b5b27b5d36d1b9491fa0e3.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:10:17 +0000
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
- [Low] selftests/sched: hotplug_user_mask_refused() fails when nisol >
  2
--

commit 1feed7a3b20fcb7febc6347a6bcad087b2151e55
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test the root domain of a task in deadline_bw_test

This commit adds 32 test cases to deadline_bw_test covering SCHED_DEADLINE
root domain bandwidth accounting across CPU hotplug, cpuset changes,
partition roots, and CPUs isolated with isolcpus=3Ddomain.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> index f50d45dd57994..87fa1a7d420fd 100644
> --- a/tools/testing/selftests/sched/deadline/deadline_bw_test.c
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c
[ ... ]
> @@ -7048,100 +7599,1873 @@ static pid_t task_from(int cpu, int all, uint6=
4_t runtime, uint64_t period, int
[ ... ]
> +static int hotplug_user_mask_refused(void)
> +{
> +	int fd[2] =3D { -1, -1 }, err, cpu, ret =3D KSFT_SKIP;
> +	long long def0, hk0, def, hk, bw;
> +	char buf[64];
> +	pid_t pid =3D -1;
> +
> +	if (fallback_cpus(0) || !cpu_hotpluggable(fb_h)) {
> +		ksft_print_msg("needs isolcpus=3Ddomain: 2 isolated, 2 housekeeping CP=
Us, hotplug\n");
> +		return KSFT_SKIP;
> +	}
> +	if (cs_setup())
> +		return KSFT_SKIP;
> +	snprintf(buf, sizeof(buf), "%d,%d,%d,%d", fb_i1, fb_i2, fb_h, fb_k);
> +	if (cs_make(cs_b, buf) || write_file(cs_b, "cgroup.subtree_control", "+=
cpuset"))
> +		goto out;
> +	snprintf(buf, sizeof(buf), "%d", fb_h);
> +	if (cs_make(cs_c, buf) || fallback_totals(&def0, &hk0) || pipe(fd))
> +		goto out;
> +	ret =3D KSFT_FAIL;
> +	mv_state[0] =3D 0;
> +	mv_state[1] =3D 0;
> +	pid =3D fork_child("a deadline task");
> +	if (!pid) {
> +		cpu_set_t set;
> +		char c;
> +
> +		CPU_ZERO(&set);
> +		CPU_SET(fb_i1, &set);
> +		CPU_SET(fb_i2, &set);
> +		if (sched_setaffinity(0, sizeof(set), &set) ||
> +		    set_deadline(0, 10 * NSEC_PER_MSEC, PERIOD)) {
> +			mv_state[0] =3D -1;
> +			_exit(1);
> +		}

[Severity: Low]
Will set_deadline() fail with EPERM here when more than two CPUs are
isolated with isolcpus=3Ddomain (nisol > 2)?

In the root cgroup, __sched_setscheduler() requires the task's affinity
mask to be a superset of def_root_domain.span, which contains all nisol
isolated CPUs rather than just fb_i1 and fb_i2.  Adding all isol[0..nisol-1]
CPUs to set before set_deadline() (as spin_offline() does), and then
narrowing the mask to fb_i1, fb_i2 and fb_h afterwards, would allow the
test to pass when nisol > 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D18
