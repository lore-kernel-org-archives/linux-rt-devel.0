Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910983;
	b=m/592W/K9vx7r33IVp0+eDu3dYNvH3ckITjU+FjL+oh0K/elJvy7Dnul1FIY6OGg+uUQ
	 /oGGHHaghlkPHdujgvKNVEM+BaiWcarBgT5DB1OzGVPR6kYk4STyel0QiOeoegqm5baOO
	 W6o0XMA8C9dyIZErT/ZxBB2PTgx/WChVhrVjzc7NJrPav9tri8vtmPOzWObs8EfmSn9qj
	 2YW/Yebhxd+Ex+5V+neXCJJxyFLJSXtlOyp+10OxI2Ca1S3Dd0hPgrlj9ffBFmPx7FFML
	 sXfusYcUuqh8tIEZRIiktCJolmTlHZCije+nKvc8iQdYSP4nu4b8qgq+Tawy3EXMQaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OxsRMgW7YlnXHvuMyY//yl0T5XbcXx9HFcrThYl0C9Q=;
	b=27hhPUiCpTHwhA+H2KmizKhPmxydLVNtJlYp088F5OeSIHh62umd+YqjXCSsvtbwN26y
	 ZsSbD0FtqU6klkp9H7LUhr6YAtb5qYllGXKziMgl7wLHPk1ZXNpmaTxlQlckehDIqfGXg
	 5O+WjB81HfTubXM01KQqrHEz4aZ9t1q11IJ/pGzs6oAJqUzcE7dN3UFe4MoLhUm9N0rth
	 X7FkmETO/8tFjzpyccO8e0ibi2bRxd3b5Ka9Dj8iygFSzE3QtrkoYLATR6XrIpSyBas4K
	 PIptYhhK96tT9IkJyzgLgBrrzF7gD9b4WrV/imXf4S/tizs9eumNzG8CwOIgukUDWkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7r0xCcn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAA9606A32F;
	Thu,  5 Nov 2026 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7r0xCcn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359DD1F0089F;
	Thu,  5 Nov 2026 20:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910982;
	bh=OxsRMgW7YlnXHvuMyY//yl0T5XbcXx9HFcrThYl0C9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7r0xCcnz3TXVtHZX5V4booVfjIemfjSweCgu0+HotvrTXnGA2t+5d2U5iiuBzEOb
	 UQSSfudAnW2w1iWhnoXZc10n7jUb8qWxRz1hQw0S8P5ZDDfk/+dyoRypx6W5N+Cy+w
	 xITsA/SOBDyxxJCFlTx2H5DuvFrrHVq51b5sUbOsAvgfAMqfsj0a2GjQIcxRquWxyS
	 C4gNUz0F0TfM3c14XWHuEJpGevnNPZJf3lwuyrVKwOAeI7+TK7Vqobv3pp2yYPt2Fk
	 D2Z4HkjgQimuLSTZFz0rCACFFFmc2GLODQB7ZBxSnJ0bcsHlaG/Ufa77Ji9dINY40m
	 1T3DSCHVkCWBA==
Message-ID: <sashiko-outbox-200117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/24] cgroup/cpuset: Wait for an attach before
 rebuilding the sched domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105193359.1450487-17-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-17-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:36:21 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cgroup/cpuset: v1 file writes rebuild sched domains during attach
--

commit 316ee12eeff2f481c38bdeab56717a9467c1a2eb
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Wait for an attach before rebuilding the sched domains

This commit updates rebuild_sched_domains_cpuslocked() to call
wait_attach_done_lock() instead of mutex_lock(&cpuset_mutex), preventing
scheduler domain rebuilds from clearing root domain deadline bandwidth
reservations while a task attach is in progress.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ae0bbe23a6332..e2b6f7a198eed 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1067,7 +1067,13 @@ void rebuild_sched_domains_locked(void)
> =20
>  static void rebuild_sched_domains_cpuslocked(void)
>  {
> -	mutex_lock(&cpuset_mutex);
> +	/*
> +	 * An attach in progress has set aside, in the root domain its tasks
> +	 * move to, the deadline bandwidth it moves once it takes
> +	 * cpuset_mutex again: the rebuild of the accounting would drop that
> +	 * reservation, and the move would go through on its strength.
> +	 */
> +	wait_attach_done_lock();
>  	rebuild_sched_domains_locked();

[Severity: High]
Does this leave cgroup v1 file writes exposed to the same race when
rebuild_sched_domains_locked() is called directly without going through
rebuild_sched_domains_cpuslocked()?

The commit message notes that writes to a cpuset's files wait for an
in-progress attach via wait_attach_done_lock() since commit 75f77a25ec6bb
("cgroup/cpuset: Prevent race between task attach and cpuset state change").
However, that commit only added the wait to cpuset_write_resmask() and
cpuset_partition_write(), leaving cpuset_full_lock() calling
mutex_lock(&cpuset_mutex) directly:

kernel/cgroup/cpuset.c:cpuset_full_lock() {
	mutex_lock(&cpuset_top_mutex);
	cpus_read_lock();
	mutex_lock(&cpuset_mutex);
}

When CONFIG_CPUSETS_V1 is enabled, writes to cpuset.sched_load_balance and
cpuset.sched_relax_domain_level go through cgroup_file_write() (which does
not hold cgroup_mutex) into cpuset_write_u64() and cpuset_write_s64(). Both
acquire cpuset_mutex via cpuset_full_lock() and invoke
rebuild_sched_domains_locked() directly via cpuset_update_flag() and
update_relax_domain_level():

kernel/cgroup/cpuset-v1.c:cpuset_update_flag() {
	...
	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
		rebuild_sched_domains_locked();
	...
}

kernel/cgroup/cpuset-v1.c:update_relax_domain_level() {
	...
	if (val !=3D cs->relax_domain_level) {
		cs->relax_domain_level =3D val;
		if (!cpumask_empty(cs->cpus_allowed) &&
		    is_sched_load_balance(cs))
			rebuild_sched_domains_locked();
	}
	...
}

If either file is written between cpuset_can_attach() and cpuset_attach(),
rebuild_sched_domains_locked() -> partition_sched_domains() ->
dl_rebuild_rd_accounting() will still run during the attach and wipe out the
destination root domain's deadline bandwidth reservation, causing
dl_bw->total_bw to underflow and over-admit deadline tasks.

Should cpuset_full_lock() call wait_attach_done_lock() instead of
mutex_lock(&cpuset_mutex) so that cpuset_write_u64(), cpuset_write_s64(),
and hk_sd_workfn() also wait for an in-progress attach to complete?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193359.1450=
487-1-mathieu.desnoyers@efficios.com?part=3D16
